require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'should mark all tasks from the list as complete' do
      list = List.create(name: "Chores")
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it 'should snooze each task(by one hour)' do
      list = List.create(name: "Chores")
      first_time = Time.new(2015, 10, 14)
      second_time = Time.new(2016, 1, 3)
      Task.create(deadline: first_time, list_id: list.id)
      Task.create(deadline: second_time, list_id: list.id)
      list.snooze_all_tasks!
      expect(list.tasks.first.deadline).to eq(first_time + 1.hour)
      expect(list.tasks.second.deadline).to eq(second_time + 1.hour)
    end
  end

  describe '#total_duration' do
    it 'should return the sum of all of the tasks' do
      list = List.create(name: "stuff to do!")
      Task.create(duration: 50, list_id: list.id)
      Task.create(duration: 100, list_id: list.id)
      total = list.total_duration
      expect(total).to eq(150)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return an array of all of the incomplete tasks' do
      list = List.create(name: "stuff to do!")
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      incomplete_tasks = list.incomplete_tasks
      expect(incomplete_tasks.count).to eq(2)
      incomplete_tasks.each do |task|
        expect(task.complete).to eq(false)
      end
    end
  end

  describe '#favorite_tasks' do
    it 'should return an array of favorite tasks' do
      list = List.create(name: "stuff to do")
      Task.create(favorite: true, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      Task.create(favorite: true, list_id: list.id)
      favorite_tasks = list.favorite_tasks
      expect(favorite_tasks.count).to eq(2)
      favorite_tasks.each do |task|
        expect(task.favorite).to eq(true)
      end
    end

  end


end

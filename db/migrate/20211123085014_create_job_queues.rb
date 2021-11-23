# frozen_string_literal: true

# class CreateJobQueues
class CreateJobQueues < ActiveRecord::Migration[6.1]
  def change
    create_table :job_queues do |t|
      t.string :name

      t.timestamps
    end
  end
end

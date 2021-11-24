# frozen_string_literal: true

# class CreateBackgroundJobs
class CreateBackgroundJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :background_jobs do |t|
      t.string :name
      t.json :job_param
      t.datetime :starts_at
      t.datetime :expires_at
      t.integer :status, default: 0, null: false
      t.integer :priority, default: 0, null: false

      t.references :job_queue, foreign_key: true, null: false

      t.timestamps
    end
  end
end

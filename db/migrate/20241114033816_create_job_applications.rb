class CreateJobApplications < ActiveRecord::Migration[7.2]
  def change
    create_table :job_applications do |t|
      t.string :email
      t.references :job, null: false, foreign_key: true
      t.string :name
      t.date :dob
      t.integer :gender
      t.text :description

      t.timestamps
    end
  end
end

class CreateJobs < ActiveRecord::Migration[7.2]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company_name
      t.string :location
      t.string :job_type
      t.text :description

      t.timestamps
    end
  end
end

class AddPublishToJobs < ActiveRecord::Migration[7.2]
  def change
    add_column :jobs, :publish, :boolean
  end
end

class CreateInterviews < ActiveRecord::Migration[6.1]
  def change
    create_table :interviews do |t|
      t.belongs_to :candidate
      t.text :requirements
      t.timestamps
    end
  end
end

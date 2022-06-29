class CreateInterviewRounds < ActiveRecord::Migration[6.1]
  def change
    create_table :interview_rounds do |t|
      t.belongs_to :interview
      t.belongs_to :employee
      t.datetime :when
      t.string :where
      t.text :review_comments
      t.string :status
      t.timestamps
    end
  end
end

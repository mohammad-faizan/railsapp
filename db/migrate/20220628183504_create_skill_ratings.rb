class CreateSkillRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :skill_ratings do |t|
      t.references :interview_round, index: true
      t.references :skill, index: true
      t.integer :rating
      t.timestamps
    end
  end
end

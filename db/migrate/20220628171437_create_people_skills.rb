class CreatePeopleSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :people_skills do |t|
      t.belongs_to :person, index: true
      t.belongs_to :skill, index: true
      t.timestamps
    end
  end
end

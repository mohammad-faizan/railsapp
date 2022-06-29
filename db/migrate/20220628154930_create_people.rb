class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
    	t.string :name
    	t.date :dob
    	t.string :email
    	t.integer :experience
    	t.string :type
    	t.references :person, index: true
      t.timestamps
    end
  end
end

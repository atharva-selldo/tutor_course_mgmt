class CreateTutors < ActiveRecord::Migration[7.1]
  def change
    create_table :tutors do |t|
      t.string :name, null: false
      t.references :course, null: false, foreign_key: true
      t.timestamps
    end
  end
end

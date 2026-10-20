class CreateLabWorks < ActiveRecord::Migration[8.1]
  def change
    create_table :lab_works do |t|
      t.references :lab_work_template, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.string :status

      t.timestamps
    end
  end
end
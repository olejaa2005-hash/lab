class CreateLabWorkTemplates < ActiveRecord::Migration[8.1]
  def change
    create_table :lab_work_templates do |t|
      t.string :title
      t.text :description
      t.references :teacher, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end

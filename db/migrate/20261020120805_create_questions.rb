class CreateQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :questions do |t|
      t.references :lab_work_template, null: false, foreign_key: true
      t.text :content
      t.string :question_type
      t.boolean :required

      t.timestamps
    end
  end
end

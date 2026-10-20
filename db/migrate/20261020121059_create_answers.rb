class CreateAnswers < ActiveRecord::Migration[8.1]
  def change
    create_table :answers do |t|
      t.references :lab_work, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.text :text_content

      t.timestamps
    end
  end
end

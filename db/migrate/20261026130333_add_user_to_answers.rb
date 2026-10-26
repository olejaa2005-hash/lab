class AddUserToAnswers < ActiveRecord::Migration[8.0]
  def change
    add_reference :answers, :user, null: false, foreign_key: true
    add_index :answers, [:user_id, :question_id], unique: true, name: "index_answers_on_user_and_question"
  end
end
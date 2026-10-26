class AddGradeAndFeedbackToLabWorks < ActiveRecord::Migration[8.1]
  def change
    add_column :lab_works, :grade, :integer
    add_column :lab_works, :feedback, :text
    add_column :lab_works, :answers, :json
  end
end

class AddIndexToLabWorksTemplateIdAndStudentId < ActiveRecord::Migration[8.0]
  def change
    add_index :lab_works, [:lab_work_template_id, :student_id], unique: true
  end
end
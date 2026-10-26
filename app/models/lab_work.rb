class LabWork < ApplicationRecord
  belongs_to :lab_work_template
  belongs_to :student, class_name: "User", foreign_key: "student_id"

  has_many_attached :files

  validates :student_id, uniqueness: { scope: :lab_work_template_id, message: "вже має цю лабораторну роботу" }
end
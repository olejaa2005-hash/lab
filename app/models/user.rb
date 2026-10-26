class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  # Зв'язки для викладача (шаблони)
  has_many :lab_work_templates, foreign_key: "teacher_id", dependent: :destroy

  # Зв'язок для студента (виконані/створені лабораторні)
  has_many :lab_works, foreign_key: "student_id", dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def teacher?
    role == "teacher"
  end

  def student?
    role == "student"
  end
end
class User < ApplicationRecord
  has_secure_password
  has_many :lab_work_templates, foreign_key: "teacher_id", dependent: :destroy
  has_many :answers, dependent: :destroy


  has_many :lab_works, foreign_key: "student_id", dependent: :destroy


  validates :email_address, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[teacher student] }
end
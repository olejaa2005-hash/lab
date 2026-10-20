class LabWorkTemplate < ApplicationRecord
  belongs_to :teacher, class_name: "User", foreign_key: "teacher_id"
  has_many :questions, dependent: :destroy
  has_many :lab_works, dependent: :destroy
  has_many :students, through: :lab_works

  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: :all_blank

  validates :title, presence: true
end
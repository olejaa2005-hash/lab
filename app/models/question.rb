class Question < ApplicationRecord
  belongs_to :lab_work_template
  has_many :answers, dependent: :destroy

  validates :content, presence: true
  validates :question_type, inclusion: { in: %w[text image code] }
end
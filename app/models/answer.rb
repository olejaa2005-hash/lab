class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :user_id, uniqueness: { scope: :question_id, message: "може надати лише одну відповідь на це питання" }
  validates :body, presence: true
end
class Question < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_one :reply

  after_create :send_question_notifications

  def send_question_notifications
    QuestionMailer.question_created(self).deliver_now
  end
end

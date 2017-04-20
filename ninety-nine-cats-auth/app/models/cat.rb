require 'action_view'

class Cat < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  validates :user_id, presence: true

  CAT_COLORS = %w(black white orange brown)

  belongs_to :owner,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    dependent: :destroy
  )

  validates(
    :birth_date,
    :color,
    :name,
    :sex,
    presence: true
  )

  validates :color, inclusion: CAT_COLORS
  validates :sex, inclusion: %w(M F)

  def age
    time_ago_in_words(birth_date)
  end
end

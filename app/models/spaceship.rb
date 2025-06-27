class Spaceship < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one_attached :photo
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :max_speed, presence: true, numericality: { greater_than: 0 }
  validates :size, presence: true, inclusion: { in: %w[small medium large "mega big"] }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :features, presence: true
  validates :photo, presence: true

  private

  def photo_presence
    errors.add(:photo, "must be attached") unless photo.attached?
  end

end

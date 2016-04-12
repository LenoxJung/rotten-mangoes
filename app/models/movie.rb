class Movie < ActiveRecord::Base

  mount_uploader :poster, PosterUploader 

  has_many :reviews

  validates :title, presence: true
  validates :director, presence:true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :poster_image_url, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_past

  scope :short_movies, -> { where('runtime_in_minutes<=90') }
  scope :medium_movies, -> { where('runtime_in_minutes>90 AND runtime_in_minutes <= 120')}
  scope :long_movies, -> { where('runtime_in_minutes>120')}

  def review_average
    if reviews.size == 0
      0
    else
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end

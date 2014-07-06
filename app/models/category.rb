class Category < ActiveRecord::Base
  has_many :videos, -> { order "created_at DESC" }
  validates_presence_of :name

  def recent_videos_cache
    Rails.cache.fetch([self, "ferst_six_videos"]) { videos.first(6) }
  end
end

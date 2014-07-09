class Event < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :description, :published_on
end

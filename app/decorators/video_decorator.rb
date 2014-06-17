class VideoDecorator < Draper::Decorator
  delegate_all

  def rating
    object.rating.present? ? "#{object.rating}/5.0" : "N/A"
  end

  def add_my_queue
    h.link_to "+ My Queue", h.queue_items_path(video_id: object.id), method: :post, class: 'btn btn-default' unless h.current_user.queued_video?(object)
  end
end
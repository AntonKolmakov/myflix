class AddPublicEventToEvents < ActiveRecord::Migration
  def change
    add_column :events, :public_event, :boolean, default: false
  end
end

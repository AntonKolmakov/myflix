class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description
      t.date :published_on

      t.timestamps
    end
  end
end

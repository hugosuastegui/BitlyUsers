class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |u|
      u.string :url_long
      u.string :url_short
      u.integer :click_count, :default => 0
      u.belongs_to :user
      u.timestamps
    end
  end
end

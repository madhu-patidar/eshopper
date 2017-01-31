class AddAttachmentPictureToBanners < ActiveRecord::Migration
  def self.up
    change_table :banners do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :banners, :picture
  end
end

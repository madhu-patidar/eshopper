class RemovePictureFileNameFromBanners < ActiveRecord::Migration
  def change
     remove_attachment :banners, :picture
  end
end

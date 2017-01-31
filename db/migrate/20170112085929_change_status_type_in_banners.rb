class ChangeStatusTypeInBanners < ActiveRecord::Migration
  def change
    remove_column :banners, :status
    add_column :banners, :status, :boolean
  end
end

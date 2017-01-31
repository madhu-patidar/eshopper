class ChangeStatusTypeInBanners < ActiveRecord::Migration
  def change
    change_column :banners, :status, :boolean
  end
end

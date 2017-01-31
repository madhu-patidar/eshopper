class ChangeColumnNameOfBanner < ActiveRecord::Migration
  def change
    rename_column :banners, :context, :content
  end
end

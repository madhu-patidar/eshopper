class AddAdminReplyColumnToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :admin_reply, :text
  end
end

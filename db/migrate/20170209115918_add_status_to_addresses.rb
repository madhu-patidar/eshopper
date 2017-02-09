class AddStatusToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :status, :string, :default => "active"
  end
end

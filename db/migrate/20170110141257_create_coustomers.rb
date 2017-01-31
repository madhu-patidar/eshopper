class CreateCoustomers < ActiveRecord::Migration
  def change
    create_table :coustomers do |t|

      t.timestamps null: false
    end
  end
end

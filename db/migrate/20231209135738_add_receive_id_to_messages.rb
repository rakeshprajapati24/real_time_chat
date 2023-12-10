class AddReceiveIdToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :receive_id, :integer
  end
end

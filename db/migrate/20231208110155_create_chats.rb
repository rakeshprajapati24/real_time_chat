class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.text :body
      t.string :user_id

      t.timestamps
    end
  end
end

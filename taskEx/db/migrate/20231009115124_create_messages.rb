class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :reciever_id
      t.text :text
      t.timestamps
    end
  end
end

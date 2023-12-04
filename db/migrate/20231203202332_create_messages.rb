class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :number, null: false
      t.references :chat, null: false, foreign_key: true

      t.index %i[chat_id number], unique: true
      t.timestamps
    end
  end
end

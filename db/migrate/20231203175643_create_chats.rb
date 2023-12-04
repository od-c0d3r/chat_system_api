class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.integer :number, null: false
      t.integer :messages_count, default: 0
      t.references :application, null: false, foreign_key: true

      t.index %i[application_id number], unique: true
      t.timestamps
    end
  end
end

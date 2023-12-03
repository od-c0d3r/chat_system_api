class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :token, null: false, index: { unique: true }
      t.string :name
      t.integer :chats_count, default: 0

      t.timestamps
    end
  end
end

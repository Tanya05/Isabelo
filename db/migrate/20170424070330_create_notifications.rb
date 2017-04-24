class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id_for
      t.integer :book_id
      t.integer :notifType
      t.date :deadline
      t.integer :user_id_about
      t.boolean :seen
      t.timestamps null: false
    end
  end
end

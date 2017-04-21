class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :genre
      t.string :isbn
      t.belongs_to :users, :uploaded_by 
      t.integer :shared_for_week
      t.belongs_to :users, :WL1 
      t.belongs_to :users, :WL2
      t.belongs_to :users, :WL3
      t.belongs_to :users, :borrowed_by
      t.integer :borrowed_for_week
      t.timestamps null: false
    end
  end
end

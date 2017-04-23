class Borrow < ActiveRecord::Migration
  def change
  	change_table :books do |t|
  		t.integer :borrow_request_by 
  		t.boolean :borrow_status
  	end
  end
end

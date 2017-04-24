class AddDatestoBooks < ActiveRecord::Migration
  def change
  	change_table :books do |t|
  		t.date :bookSharedOn 
		t.date :bookSharedTill
  	end
  end
end

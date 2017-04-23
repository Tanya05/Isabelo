class AddWLweeks < ActiveRecord::Migration
  def change
  	change_table :books do |t|
  		t.integer :WL1RequestWeeks 
		t.integer :WL2RequestWeeks
		t.integer :WL3RequestWeeks
  	end
  end
end

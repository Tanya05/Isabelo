class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :presence => true, :email => true
  validates_format_of :email, :with => /iiitb\.org/, :message => "should have the domain @iiitb.org"

end

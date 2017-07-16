class User < ActiveRecord::Base
  
  has_many :wikis 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  enum role: [:standard, :premium, :admin]
  
 def going_public
    self.wikis.each { |wiki| puts wiki.publicize }
 end
end

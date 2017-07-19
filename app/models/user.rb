class User < ActiveRecord::Base
  
  has_many :wikis 
  has_many :collaborators
  has_many :wikis, through: :collaborators
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  enum role: [:standard, :premium, :admin]
  
 def going_public
    self.wikis.each { |wiki| puts wiki.publicize }
 end
end

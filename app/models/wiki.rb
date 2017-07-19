class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  
  validates :user, presence: true
  
  scope :visible_to, -> (user) { user ? all : where(private: false) }
   
   def publicize
     update_attribute(:private, false)
   end
end

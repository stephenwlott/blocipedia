class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  
  def is_public?
    private != true
  end
 
  def is_private?
    private == true
  end
  
end

class Wiki < ActiveRecord::Base
  belongs_to :user
  
  def is_public?
    private != true
  end
 
  def is_private?
    private == true
  end
end

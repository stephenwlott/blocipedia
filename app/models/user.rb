class User < ActiveRecord::Base
  after_initialize :set_default_role
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :wikis
  has_many :collaborators
  
  def is_admin?
    role == 'admin'
  end
  
  def is_premium?
    role == 'premium'
  end
  
  def is_standard?
    role == 'standard'
  end
  
  private
  
  def set_default_role
    if !role
      assign_attributes(:role => 'standard')
    end
  end
  
end

class User < ActiveRecord::Base
  after_initialize :set_default_role
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many  :wikis, dependent: :destroy
  
  def admin?
    role == 'admin'
  end
  
  def premium?
    role == 'premium'
  end
  
  def standard?
    role == 'standard'
  end
  
  private
  
  def set_default_role
    if !role
      assign_attributes(:role => 'standard')
    end
  end
  
end

class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :name
  field :avatar
  field :topics_count, :type => Integer, :default => 0

  embeds_many :roles
  has_many :topics

  mount_uploader :avatar, AvatarUploader
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :avatar
  
  def update_with_password(params={})
    params.delete(:current_password)
    self.update_without_password(params)
  end

  def role?(role)
    return !!self.roles.where({"name" => /#{role.to_s}/}).first
  end
end

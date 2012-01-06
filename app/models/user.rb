class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :name
  field :avatar
  field :topics_count, :type => Integer, :default => 0
  
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :avatar

  embeds_many :roles
  has_many :topics
  has_many :replies
  has_many :groups, :inverse_of => :creator
  has_and_belongs_to_many :admin_of, :inverse_of => :admins, :class_name => 'Group'
  has_and_belongs_to_many :member_of, :inverse_of => :members, :class_name => 'Group'

  mount_uploader :avatar, AvatarUploader
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  
  def update_with_password(params={})
    params.delete(:current_password)
    self.update_without_password(params)
  end
  
  def role?(role)
    return !!self.roles.where({"name" => /#{role.to_s}/}).first
  end
  
  def create_group(attributes)
    group = self.groups.new(attributes)
    group.members << self
    group
  end
  
  def create_topic(attributes, group)
    topic = self.topics.new(attributes)
    topic.group = group
    topic
  end
  
  def is_member_of?(group)
    self.member_of.include?(group)
  end
  
  def become_member_of(group)
    if group.allowadduser and group.verified and !self.is_member_of?(group)
      group.members << self
      group.save!
    end
  end
  
  def leave(group)
    if self.is_member_of?(group)
      group.member_ids.delete self.id
      group.save!
    end
  end
end

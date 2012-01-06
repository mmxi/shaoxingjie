class Group
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::CounterCache
  include Mongoid::Timestamps
  
  field :title
  field :introduction
  field :topics_count, :type => Integer, :default => 0
  field :members_count, :type => Integer, :default => 0
  field :verified, :type => Boolean, :default => false
  field :allowadduser, :type => Boolean, :default => true
  field :picture
  auto_increment :num
  
  attr_accessible :title, :introduction, :picture
  attr_accessor :accessible
  
  mount_uploader :picture, GroupUploader
  
  has_many :topics
  belongs_to :creator, :class_name => 'User'
  has_and_belongs_to_many :admins,  :inverse_of => :admin_of, :class_name => 'User'
  has_and_belongs_to_many :members, :inverse_of => :member_of, :class_name => 'User'
  
  before_save :update_members
    
  validates_presence_of :title
  validates_uniqueness_of :title
  validates_presence_of :introduction
  
  def to_param
    num.to_s
  end
  
  def self.find_by_num(num)
    where(num: num).first
  end
  
  def update_members
    self.members_count = self.members.size
  end

  def self.search(keyword)
    if !keyword.blank?
     where(:title => /^#{keyword}/)
    else
     all
    end
  end

  private
    def mass_assignment_authorizer(role = :default)
      if accessible == :all  
        self.class.protected_attributes  
      else  
        super + (accessible || [])  
      end 
    end
end
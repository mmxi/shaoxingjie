class Topic
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps
  include Mongoid::CounterCache
  
  field :title
  field :category
  field :body
  field :hits, :type => Integer, :default => 0
  field :allowreply, :type => Boolean, :default => true
  auto_increment :num
  
  belongs_to :group
  belongs_to :user, :inverse_of => :topics
  has_many :replies
  
  index :user_id
  index :group_id

  counter_cache :name => :group, :inverse_of => :topics
  counter_cache :name => :user, :inverse_of => :topics

  validates_presence_of :title
  validates_presence_of :body

  def to_param
    num.to_s
  end

  def self.find_by_num(num)
    first(conditions: { num: num })
  end
  
  def self.recent
    all.includes(:group, :user).limit(5).desc(:created_at)
  end
end

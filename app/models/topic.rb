class Topic
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CounterCache
  
  field :title
  field :stitle
  field :body
  field :hits, :type => Integer, :default => 0
  field :locked, :type => Boolean, :default => false
  auto_increment :num
  
  belongs_to :forum
  belongs_to :user, :inverse_of => :topics
  
  index :user_id
  index :forum_id

  counter_cache :name => :forum, :inverse_of => :topics
  counter_cache :name => :user, :inverse_of => :topics

  validates_presence_of :title
  validates_presence_of :body

  def to_param
    num.to_s
  end
end

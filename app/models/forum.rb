class Forum
  include Mongoid::Document

  field :name
  field :description
  field :sort, :type => Integer, :default => 0
  field :topics_count, :type => Integer, :default => 0
  field :picture
  auto_increment :num

  has_many :topics

  validates_presence_of :name
  validates_uniqueness_of :name

  scope :sorted, desc(:sort)

  def to_param
    num.to_s
  end

  def self.find_by_num(num)
    Forum.where(num: num).first
  end
end

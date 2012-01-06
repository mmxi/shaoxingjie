class Reply
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CounterCache
  
  field :body
  
  belongs_to :topic
  belongs_to :user
end

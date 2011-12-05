class Topic
  include Mongoid::Document
  
  field :title
  field :body
  
  belongs_to :forum
end

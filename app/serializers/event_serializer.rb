class EventSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :description, :date, :location, :poster_url, :user_id, :category_id

  # Define the relationships to include
  belongs_to :user
  belongs_to :category
  has_many :participants 
end

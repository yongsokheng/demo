class Entry < ActiveRecord::Base
	default_scope -> {order(created_at: :desc)}

	validates :title, presence: true, length: {maximum: 100}
	validates :body, presence: true
	
	belongs_to :user
	has_many :comments, dependent: :destroy

end

class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :image, presence: true 
    validates :link, presence: true
    validates :description, presence: true
    acts_as_votable
    belongs_to :user 
    has_many :comments
    has_attached_file :image, styles: { medium: "500x400>", small: "350x250>" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end

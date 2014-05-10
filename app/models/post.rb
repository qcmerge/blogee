class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  has_and_belongs_to_many :tags

  before_create :associate_tags

  attr_accessor :tag_names

  mount_uploader :asset, AssetUploader

  validates :title, :presence => true
  validates :content, :presence => true

  scope :published, -> { where('published_at IS NOT NULL') }

  private

  def associate_tags
    if tag_names
      tag_names.split(" ").each do |name|
        self.tags << Tag.find_or_create_by(name: name)
      end
    end
  end
end

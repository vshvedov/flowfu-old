class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment
  include ActionView::Helpers

  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_one :upload

  validates_presence_of :user_id
  validates_presence_of :comment

  default_scope :order => 'created_at ASC'

  accepts_nested_attributes_for :upload, :allow_destroy => true

  def get_comment
    auto_link(RedCloth.new(comment).to_html, :all, :target => "_blank")#{|text|truncate(text, :lenght => 30)}
  end
end

# == Schema Information
#
# Table name: comments
#
#  id               :integer         not null, primary key
#  title            :string(50)      default("")
#  comment          :text            default("")
#  commentable_id   :integer
#  commentable_type :string(255)
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#


class Upload < ActiveRecord::Base

  belongs_to :project
  belongs_to :user
  belongs_to :comment
  has_attached_file :node, :styles => { :medium => "800x600>", :thumb => "100x100#" }

  validates_attachment_presence :node
  validates_presence_of :user_id
  validates_presence_of :project_id

  default_scope :order => 'updated_at DESC'

  before_post_process :image?
  def image?
    !(node_content_type =~ /^image.*/).nil?
  end

  def icon
    if File.file? "#{RAILS_ROOT}/public/images/mime/#{node_content_type.parameterize}.png"
      "/images/mime/#{node_content_type.parameterize}.png"
    else
      "/images/mime/default.png"
    end
  end
end

# == Schema Information
#
# Table name: uploads
#
#  id                :integer         not null, primary key
#  project_id        :integer
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  node_file_name    :string(255)
#  node_content_type :string(255)
#  node_file_size    :integer
#  node_updated_at   :datetime
#


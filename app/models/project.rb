class Project < ActiveRecord::Base
  acts_as_commentable

  has_many :tasks
  has_and_belongs_to_many :users
  has_many :uploads

  def has_user? user
    user.is_admin? || users.inclide?(user)
  end
end

# == Schema Information
#
# Table name: projects
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#


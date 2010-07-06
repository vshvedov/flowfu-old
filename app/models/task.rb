class Task < ActiveRecord::Base
  acts_as_commentable
  acts_as_taggable

  belongs_to :project
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :user_id
  validates_presence_of :project_id

  named_scope :opened, :conditions => {:closed_at => nil}
  named_scope :opened_in_day, lambda { |day| {:conditions => ['created_at > :begin_day AND created_at < :end_day', {:begin_day => day, :end_day => (day + 1.day)}] }}
  named_scope :closed_in_day, lambda { |day| {:conditions => ['closed_at > :begin_day AND closed_at < :end_day', {:begin_day => day, :end_day => (day + 1.day)}] }}
  named_scope :assigned_to, lambda { |user_id| { :conditions => ['user_id = ?', user_id.to_i] } }
  
  
  default_scope :order => 'closed_at DESC, updated_at DESC'

  def closed?
    !closed_at.nil?
  end

  def close_task
    self.closed_at = Time.now
    self.save
  end

  def open_task
    self.closed_at = nil
    self.save
  end
end

# == Schema Information
#
# Table name: tasks
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  user_id     :integer
#  project_id  :integer
#  closed_at   :datetime
#  created_at  :datetime
#  updated_at  :datetime
#


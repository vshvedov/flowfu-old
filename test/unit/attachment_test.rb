require 'test_helper'

class AttachmentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: attachments
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


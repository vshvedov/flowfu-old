class AddCommentIdColumnToUpload < ActiveRecord::Migration
  def self.up
    add_column :uploads, :comment_id, :integer
  end

  def self.down
    remove_column :uploads, :comment_id
  end
end

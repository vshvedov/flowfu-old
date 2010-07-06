class AddDescriptionColumnToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :description, :text
  end

  def self.down
    remove_column :uploads, :description
  end
end

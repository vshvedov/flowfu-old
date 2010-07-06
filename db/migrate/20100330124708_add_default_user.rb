class AddDefaultUser < ActiveRecord::Migration
  def self.up
    User.create!(:email => "evgeny.gurin@gmail.com", :password => "hobibob")
  end

  def self.down
    User.destroy_all
  end
end

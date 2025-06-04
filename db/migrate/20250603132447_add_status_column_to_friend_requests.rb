class AddStatusColumnToFriendRequests < ActiveRecord::Migration[8.0]
  def change
    add_column :friend_requests, :status, :integer
  end
end

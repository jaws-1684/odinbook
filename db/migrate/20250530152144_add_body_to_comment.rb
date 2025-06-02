class AddBodyToComment < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :body, :string
  end
end

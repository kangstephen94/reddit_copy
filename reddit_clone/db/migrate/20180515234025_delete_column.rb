class DeleteColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :sub_id, :integer
  end
end

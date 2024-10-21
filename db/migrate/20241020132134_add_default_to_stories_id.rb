class AddDefaultToStoriesId < ActiveRecord::Migration[5.2]
  def change
    change_column :stories, :id, :string, null: false, default: ''
  end
end

class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories, id: false do |t|
      t.string :id, null: false
      t.string :title
      t.string :url
      t.integer :score
      t.timestamps
    end
    add_index :stories, :id, unique: true
  end
end

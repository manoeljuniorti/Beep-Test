class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments, id: false do |t|
      t.string :id, null: false
      t.text :text
      t.string :user
      t.references :story, foreign_key: true, type: :string
      t.timestamps
    end
    add_index :comments, :id, unique: true
  end
end

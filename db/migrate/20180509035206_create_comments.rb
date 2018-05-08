class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :rating
      t.string :title
      t.string :content

      t.timestamps
    end
  end
end

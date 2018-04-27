class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :password_digest
      t.string :activation_digest
      t.string :phone
      t.string :address
      t.integer :sex
      t.boolean :activated
      t.integer :status
      t.integer :roles

      t.timestamps
    end
  end
end

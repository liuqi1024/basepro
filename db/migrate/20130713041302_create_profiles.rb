class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :nickname
      t.string :weibo
      t.string :qq
      t.text :intro
      t.references :user

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end

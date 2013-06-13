class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.integer :owner_id
      t.string :owner_type
      t.text :desc
      t.attachment :source

      t.timestamps
    end
  end
end

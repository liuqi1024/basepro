class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.integer :owner_id
      t.string :owner_type
      t.text :desc
      t.has_attached_file :source

      t.timestamps
    end
  end
end

class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :title
      t.string :desc
      t.references :cover

      t.timestamps
    end
    add_index :forums, :cover_id
  end
end

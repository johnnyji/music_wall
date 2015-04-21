class CreateSongs < ActiveRecord::Migration
  def up
    create_table :songs do |t|
      t.string :title
      t.string :author
      t.string :url
      
      t.timestamps null: false
    end
  end

  def down
  end
end
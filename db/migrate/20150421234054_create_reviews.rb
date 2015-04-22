class CreateReviews < ActiveRecord::Migration
  def up
    create_table :reviews do |t|
      t.references :song, index: true
      t.references :user, index: true
      t.string :content

      t.timestamps null: false
    end
  end

  def down
    drop_table :reviews
  end
end

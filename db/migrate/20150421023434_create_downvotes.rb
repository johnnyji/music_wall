class CreateDownvotes < ActiveRecord::Migration
  def change
    create_table :downvotes do |t|
      t.references :user, index: true
      t.references :song, index: true
    end
  end
end

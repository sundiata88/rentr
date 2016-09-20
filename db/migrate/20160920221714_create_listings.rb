class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end

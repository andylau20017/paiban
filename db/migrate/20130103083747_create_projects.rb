class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :star
      t.integer :progress
      t.string :image_url
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end

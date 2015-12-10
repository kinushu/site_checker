class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :title
      t.datetime :checked_at
      t.string :uri_host
      t.string :uri_path
      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end

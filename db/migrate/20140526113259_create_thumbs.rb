class CreateThumbs < ActiveRecord::Migration
  def change
    create_table :thumbs do |t|
      t.string :uid
      t.string :job

      t.timestamps
    end
  end
end

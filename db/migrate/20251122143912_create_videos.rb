class CreateVideos < ActiveRecord::Migration[8.1]
  def change
    create_table :videos do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.references :voice_sample, null: false, foreign_key: true
      t.string :status
      t.string :video_url

      t.timestamps
    end
  end
end

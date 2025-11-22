class CreateVoiceSamples < ActiveRecord::Migration[8.1]
  def change
    create_table :voice_samples do |t|
      t.references :profile, null: false, foreign_key: true
      t.integer :duration

      t.timestamps
    end
  end
end

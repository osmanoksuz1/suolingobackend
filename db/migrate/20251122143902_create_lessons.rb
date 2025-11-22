class CreateLessons < ActiveRecord::Migration[8.1]
  def change
    create_table :lessons do |t|
      t.references :profile, null: false, foreign_key: true
      t.text :lesson_text
      t.string :difficulty_level

      t.timestamps
    end
  end
end

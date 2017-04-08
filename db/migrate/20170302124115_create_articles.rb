class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.boolean :published
      t.date :published_date

      t.timestamps null: false
    end
  end
end

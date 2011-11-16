class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string       :name
      t.string       :description
      t.text         :content
      t.boolean      :published,    :default => false
      t.references   :user
      t.timestamps
    end

  end
end

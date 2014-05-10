class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
    end

    create_table :tags_posts, id: false do |t|
      t.integer :tag_id, :post_id
    end
  end
end

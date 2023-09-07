class CreateMovieSearchCache < ActiveRecord::Migration[7.0]
  def change
    create_table :movie_search_caches do |t|
      t.string :query_params, null: false
      t.jsonb :data, default: {}
      t.integer :counter, default: 0
      t.datetime :cached_at

      t.timestamps
    end

    add_index :movie_search_caches, :query_params, unique: true
  end
end

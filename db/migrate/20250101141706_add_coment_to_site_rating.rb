class AddComentToSiteRating < ActiveRecord::Migration[7.1]
  def change
    add_column :site_ratings, :comment, :string
  end
end

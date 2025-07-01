class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.string :name, null: false
      t.text :profile_image
      t.string :nickname
      t.string :sns_x_id
      t.string :sns_instagram_id
      t.string :sns_facebook_id
      t.integer :birth_month
      t.integer :birth_day
      t.string :constellation
      t.string :birthplace
      t.string :personality_main
      t.string :personality_sub
      t.string :evaluation_others
      t.string :hobby_or_interest
      t.string :favorite_food
      t.string :favorite_drink
      t.string :favorite_artist
      t.string :favorite_book
      t.string :favorite_movie
      t.string :favorite_anime_game
      t.string :favorite_place
      t.string :special_skill
      t.string :things_i_want
      t.string :future_dream
      t.string :motto
      t.text :free_message, limit: 500

      t.timestamps
    end
  end
end

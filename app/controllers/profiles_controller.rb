class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(post_params)
    @profile.save 
    redirect_to action: 'pages#home'
  end

  private
  
  def post_params
    params.require(:profile).permit(:name, :nickname, :birth_month, :birth_day, :constellation, :birthplace, :personality_main, :personality_sub, :evaluation_others, :hobby_or_interest, :favorite_food, :favorite_drink, :favorite_artist, :favorite_book, :favorite_movie, :favorite_place, :special_skill, :things_i_want, :future_dream, :motto, :free_message)
  end
end

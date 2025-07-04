class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all.order("created_at ASC")
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(post_params)
    if @profile.save
      redirect_to profile_path(@profile.public_uid), success: t('profiles.create.success', name: @profile.name )
    else
      flash.now[:danger] = t('profiles.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @profile = Profile.find_by(public_uid: params[:id])
  end

  private

  def post_params
    params.require(:profile).permit(:name, :nickname, :birth_month, :birth_day, :constellation, :birthplace, :personality_main, :personality_sub, :evaluation_others, :hobby_or_interest, :favorite_food, :favorite_drink, :favorite_artist, :favorite_book, :favorite_movie, :favorite_place, :special_skill, :things_i_want, :future_dream, :motto, :free_message)
  end
end

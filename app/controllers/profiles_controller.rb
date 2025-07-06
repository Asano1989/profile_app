class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  
  def index
    if user_signed_in?
      @profiles = Profile.where(user_id: current_user.id)
    else
      # todo: 公開するときは全件が表示されないようにする
      @profiles = Profile.all.order("created_at ASC")
    end
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    if user_signed_in?
      @profile.user_id = current_user.id
    end

    if @profile.save
      redirect_to profile_path(@profile.public_uid), success: t('profiles.create.success', name: @profile.name )
    else
      flash.now[:danger] = t('profiles.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile.public_uid), success: t('profiles.edit.success', name: @profile.name )
    else
      flash.now[:danger] = t('profiles.update.failure')
      render :update, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy
    redirect_to profiles_path
  end

  private

  def set_profile
    @profile = Profile.find_by!(public_uid: params[:public_uid])
  end

  def profile_params
    params.require(:profile).permit(:name, :nickname, :birth_month, :birth_day, :constellation, :birthplace, :personality_main, :personality_sub, :evaluation_others, :hobby_or_interest, :favorite_food, :favorite_drink, :favorite_artist, :favorite_book, :favorite_movie, :favorite_place, :special_skill, :things_i_want, :future_dream, :motto, :free_message)
  end
end

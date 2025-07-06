class Profile < ApplicationRecord
  belongs_to :user, optional: true
  generate_public_uid

  NGWORD_REGEX = /(.)\1{4,}/.freeze
  with_options format: { without: NGWORD_REGEX } do
    with_options length: { maximum: 32 } do
      validates :name, presence: true
      validates :nickname
    end
  end
    validates :birth_month, format: { with: /\A((1[0-2]|[1-9]))?\z/ }, allow_blank: true
    validates :birth_day, format: { with: /\A((3[01]|[12][0-9]|[1-9]))?\z/ }, allow_blank: true
  # constellation, birthplace, personality_main, personality_sub, evaluation_othersにバリデーション設定を付与するならここに記載
  with_options format: { without: NGWORD_REGEX } do
    with_options length: { maximum: 50 } do
      validates :hobby_or_interest
      validates :favorite_food
      validates :favorite_drink
      validates :favorite_artist
      validates :favorite_book
      validates :favorite_movie
      validates :favorite_anime_game
      validates :favorite_place
      validates :special_skill
      validates :things_i_want
    end
    with_options length: { maximum: 80 } do
      validates :future_dream
      validates :motto
    end
    validates :free_message, length: { maximum: 300 }
  end
  validate :no_profanity

  def to_param
    public_uid
  end

  private

  PROFANITY_CHECK_COLUMNS = %i[
    name
    nickname
    constellation
    birthplace
    personality_main
    personality_sub
    evaluation_others
    hobby_or_interest
    favorite_food
    favorite_drink
    favorite_artist
    favorite_book
    favorite_movie
    favorite_place
    special_skill
    things_i_want
    future_dream
    motto
    free_message
  ].freeze

  def no_profanity
    PROFANITY_CHECK_COLUMNS.each do |column|
      value = self[column]
      next if value.blank?

      normalized = ObscenityFilterHelper.normalized_for_check(value)
      if Obscenity.profane?(normalized)
        errors.add(column, "：不適切な表現が含まれています")
      end
    end
  end
end

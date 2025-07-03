class Profile < ApplicationRecord
  generate_public_uid

  NGWORD_REGEX = /(.)\1{3,}/.freeze
  with_options format: { without: NGWORD_REGEX, message: "：4文字以上の繰り返しは禁止です" } do
    with_options length: { maximum: 32, message: "：文字数オーバーです（32文字まで）" } do
      validates :name, presence: true
      validates :nickname
    end
  end
    validates :birth_month, format: { with: /\A((1[0-2]|[1-9]))?\z/, message: "は1月〜12月の形式で入力してください" }, allow_blank: true
    validates :birth_day, format: { with: /\A((3[01]|[12][0-9]|[1-9]))?\z/, message: "は1月〜12月の形式で入力してください" }, allow_blank: true
    # validates :constellation
    # validates :birthplace
    # validates :personalty_main
    # validates :personalty_sub
    # validates :evaluation_others
  with_options format: { without: NGWORD_REGEX, message: "：4文字以上の繰り返しは禁止です" } do
    with_options length: { maximum: 50, message: "：文字数オーバーです（50文字まで）" } do
      validates :hobby_or_interest
      validates :favorite_food
      validates :favorite_drink
      validates :favorite_artist
      validates :favorite_book
      validates :favorite_movie
      validates :favorite_place
      validates :special_skill
      validates :things_i_want
    end
    with_options length: { maximum: 80, message: "：文字数オーバーです（80文字まで）" } do
      validates :future_dream
      validates :motto
    end
    validates :free_message, length: { maximum: 500, message: "：文字数オーバーです（500文字まで）" }
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

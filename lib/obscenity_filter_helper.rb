require "nkf"

module ObscenityFilterHelper
  # テキストがnilや空白でも安全に扱う
  def self.to_hiragana(text)
    normalized = NKF.nkf("-w -Z1", text.to_s)
    normalized.tr("ァ-ン", "ぁ-ん") # カタカナ→ひらがな
  end

  # 伏字に使われる記号を「○」に統一
  def self.normalize_obscured(text)
    text.gsub(/[○●☆※＊◎@★◇◆]/, "○")
  end

  # Obscenityによるフィルタリング前に前処理（ひらがな化・伏字統一・小文字化）
  def self.normalized_for_check(text)
    normalize_obscured(to_hiragana(text.to_s.downcase.strip))
  end
end

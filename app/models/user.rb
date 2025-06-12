class User < ApplicationRecord
  has_many :messages, dependent: :destroy

  def ai_assistant?
    !fingerprint.to_i.positive?
  end
end

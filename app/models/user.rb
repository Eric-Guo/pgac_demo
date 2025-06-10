class User < ApplicationRecord
  has_many :messages, dependent: :destroy
end

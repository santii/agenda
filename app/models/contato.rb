class Contato < ApplicationRecord
  validates :nome, presence: true
  belongs_to :usuario
end

class Usuario < ApplicationRecord
  validates :token, uniqueness: true
  has_many :contatos
end

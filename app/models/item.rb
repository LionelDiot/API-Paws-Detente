class Item < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :favorite_items, dependent: :destroy
  has_many :users, through: :favorite_items
  enum category: { autre: 0, chien: 1, chat: 2, oiseau: 3 }
end

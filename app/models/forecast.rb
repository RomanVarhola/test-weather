class Forecast < ApplicationRecord
  belongs_to :user

  validates :temperature, :description, :date, :address, presence: true
end

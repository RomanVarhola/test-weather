class Forecast < ApplicationRecord
  belongs_to :user

  validates :temperature, :description, :date, presence: true
end

class AddReferenceUserToForecast < ActiveRecord::Migration[5.1]
  def change
    add_reference :forecasts, :user, index: false
  end
end

class CreateForecasts < ActiveRecord::Migration[5.1]
  def change
    create_table :forecasts do |t|
      t.integer :temperature
      t.string :address
      t.text :description
      t.date :date
      
      t.timestamps
    end
  end
end

class RemoveSensorAndActuatorColumnsFromBasicResource < ActiveRecord::Migration[5.0]
  def change
    change_table :basic_resources do |t|
      t.remove :boolean, :sensor
      t.remove :boolean, :actuator
    end
  end
end

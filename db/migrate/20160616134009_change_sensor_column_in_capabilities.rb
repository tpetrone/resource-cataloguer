class ChangeSensorColumnInCapabilities < ActiveRecord::Migration[5.0]
  def change
    change_table :capabilities do |t|
      t.remove :boolean, :sensor
      t.integer :function
    end
  end
end

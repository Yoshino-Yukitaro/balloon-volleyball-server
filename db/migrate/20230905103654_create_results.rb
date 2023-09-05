class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results, if_not_exists: true do |t|
      t.integer :point, null: false

      t.timestamps
    end
  end
end

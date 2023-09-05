class CreateParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :participants, if_not_exists: true do |t|
      t.integer :result_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :participants, [:user_id, :result_id], unique: true
    add_index :participants, :user_id, unique: false
  end
end

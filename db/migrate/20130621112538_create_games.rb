class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player1
      t.integer :player2
      t.integer :winner
      t.string  :moves
      t.timestamps
    end
  end
end

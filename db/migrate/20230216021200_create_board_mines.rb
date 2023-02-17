class CreateBoardMines < ActiveRecord::Migration[7.0]
  def change
    create_table :board_mines do |t|
      t.belongs_to :board 
      t.integer :col
      t.integer :row

      t.timestamps
    end
  end
end

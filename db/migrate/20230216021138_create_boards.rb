class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :name
      t.string :user_email
      t.integer :dimension
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end

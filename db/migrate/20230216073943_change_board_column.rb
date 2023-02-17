class ChangeBoardColumn < ActiveRecord::Migration[7.0]
    def self.up
        rename_column :boards, :dimension, :mine_num
      end
    
      def self.down
        rename_column :boards, :mine_num, :dimension
      end
  end
  
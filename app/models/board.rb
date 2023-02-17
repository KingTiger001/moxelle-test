class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        record.errors.add attribute, (options[:message] || "is not an email")
        end
    end
end

class Board < ApplicationRecord
    has_many :board_mines, dependent: :destroy

    validates :name, presence: true
    validates :user_email, presence: true, email: true
    validates :mine_num, numericality: { only_integer: true }
    validates :height, comparison: { greater_than: 1 }, numericality: { only_integer: true }
    validates :width, comparison: { greater_than: 1 }, numericality: { only_integer: true }
    validate :mine_number
      
    def mine_number
        errors.add(:mine_num, "can't greather than multiplication of height and width") if !mine_num || mine_num > height * width
    end
end


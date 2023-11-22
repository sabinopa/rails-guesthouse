class Review < ApplicationRecord
  belongs_to :booking 
  belongs_to :guest, through: :booking
  
end

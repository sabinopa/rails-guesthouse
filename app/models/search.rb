class Search < ApplicationRecord
  self.inheritance_column = "not_sti"
  
  def search_rooms
    rooms = Room.active

    rooms = rooms.where(['bathroom LIKE ?', bathroom]) if bathroom.present?
    rooms = rooms.where(['balcony LIKE ?', balcony]) if balcony.present?
    rooms = rooms.where(['air_conditioner LIKE ?', air_conditioner]) if air_conditioner.present?
    rooms = rooms.where(['tv LIKE ?', tv]) if tv.present?
    rooms = rooms.where(['wardrobe LIKE ?', wardrobe]) if wardrobe.present?
    rooms = rooms.where(['safe LIKE ?', safe]) if safe.present?
    rooms = rooms.where(['accessibility LIKE ?', accessibility]) if accessibility.present?

    return rooms
  end
end

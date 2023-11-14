class Search < ApplicationRecord
  self.inheritance_column = "not_sti"
  
  def search_room
    room = Room.active

    room = room.where(['bathroom LIKE ?', bathroom]) if bathroom.present?
    room = room.where(['balcony LIKE ?', balcony]) if balcony.present?
    room = room.where(['air_conditioner LIKE ?', air_conditioner]) if air_conditioner.present?
    room = room.where(['tv LIKE ?', tv]) if tv.present?
    room = room.where(['wardrobe LIKE ?', wardrobe]) if wardrobe.present?
    room = room.where(['safe LIKE ?', safe]) if safe.present?
    room = room.where(['accessibility LIKE ?', accessibility]) if accessibility.present?

    return room
  end
end

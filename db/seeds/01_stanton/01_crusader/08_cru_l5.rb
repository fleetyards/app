# frozen_string_literal: true

# TODO: update screenshot and docks

crusader = CelestialObject.find_or_create_by!(name: 'Crusader')

hidden = false

cru_l5 = Station.find_or_initialize_by(name: 'Rest & Relax (CRU-L5)')
cru_l5.update!(
  celestial_object: crusader,
  station_type: :rest_stop,
  location: 'CRU-L5',
  store_image: Rails.root.join('db/seeds/images/stanton/crusader/cru-l5/cru-l5.jpg').open,
  hidden: hidden
)

cru_l5.docks.destroy_all
{ medium: [1, 2, 3, 4] }.each do |ship_size, pads|
  pads.each do |pad|
    cru_l5.docks << Dock.new(
      name: ("%02d" % pad),
      dock_type: :landingpad,
      ship_size: ship_size,
    )
  end
end
{ large: [5, 6] }.each do |ship_size, hangars|
  hangars.each do |hangar|
    cru_l5.docks << Dock.new(
      name: ("%02d" % hangar),
      dock_type: :hangar,
      ship_size: ship_size,
    )
  end
end

admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: cru_l5)
admin_office.update!(
  shop_type: :admin,
  store_image: Rails.root.join('db/seeds/images/stanton/crusader/cru-l5/admin.jpg').open,
  hidden: hidden
)

live_fire_weapons = Shop.find_or_initialize_by(name: 'Livefire Weapons', station: cru_l5)
live_fire_weapons.update!(
  shop_type: :weapons,
  store_image: Rails.root.join('db/seeds/images/stanton/crusader/cru-l5/weapons.jpg').open,
  hidden: hidden
)

casaba = Shop.find_or_initialize_by(name: 'Casaba Outlet', station: cru_l5)
casaba.update!(
  shop_type: :clothing,
  store_image: Rails.root.join('db/seeds/images/stanton/crusader/cru-l5/casaba.jpg').open,
  hidden: hidden
)

platinum_bay = Shop.find_or_initialize_by(name: 'Platinum Bay', station: cru_l5)
platinum_bay.update!(
  shop_type: :components,
  store_image: Rails.root.join('db/seeds/images/stanton/crusader/cru-l5/platinum.jpg').open,
  hidden: hidden
)

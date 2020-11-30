# frozen_string_literal: true

microtech = CelestialObject.find_or_create_by!(name: 'microTech')

hidden = false

porttressler = Station.find_or_initialize_by(name: 'Port Tressler')
porttressler.update!(
  celestial_object: microtech,
  station_type: :station,
  classification: :trading,
  location: nil,
  # store_image: Rails.root.join('db/seeds/images/stanton/microtech/porttressler/porttressler.jpg').open,
  hidden: false,
  refinary: true,
  cargo_hub: true
)

porttressler.docks.destroy_all
{ small: [1, 3], large: [2, 4] }.each do |ship_size, pads|
  pads.each do |pad|
    porttressler.docks << Dock.new(
      name: ('%02d' % pad),
      dock_type: :landingpad,
      ship_size: ship_size
    )
  end
end
{ large: [1, 2, 3, 4] }.each do |ship_size, hangars|
  hangars.each do |hangar|
    porttressler.docks << Dock.new(
      name: ('%02d' % hangar),
      dock_type: :hangar,
      ship_size: ship_size
    )
  end
end

porttressler.habitations.destroy_all
%w[1 2 3 4 5].each do |level|
  pad = 1
  { container: 11 }.each do |hab_size, count|
    count.times do
      porttressler.habitations << Habitation.new(
        name: "Hab #{level}#{'%02d' % pad}",
        habitation_name: 'EZ Hab',
        habitation_type: hab_size
      )
      pad += 1
    end
  end
end

admin_office = Shop.find_or_initialize_by(name: 'Admin Office', station: porttressler)
admin_office.update!(
  shop_type: :admin,
  store_image: Rails.root.join('db/seeds/images/stanton/microtech/porttressler/admin.jpg').open,
  buying: true,
  selling: true,
  hidden: hidden
)

bulwark_armor = Shop.find_or_initialize_by(name: 'Bulwark Armor', station: porttressler)
bulwark_armor.update!(
  shop_type: :armor,
  store_image: Rails.root.join('db/seeds/images/stanton/microtech/porttressler/armor.jpg').open,
  selling: true,
  hidden: hidden
)

platinum_bay = Shop.find_or_initialize_by(name: 'Platinum Bay', station: porttressler)
platinum_bay.update!(
  shop_type: :components,
  store_image: Rails.root.join('db/seeds/images/stanton/microtech/porttressler/platinum_bay.jpg').open,
  selling: true,
  hidden: hidden
)

casaba = Shop.find_or_initialize_by(name: 'Casaba Outlet', station: porttressler)
casaba.update!(
  shop_type: :clothing,
  store_image: Rails.root.join('db/seeds/images/stanton/microtech/porttressler/casaba.jpg').open,
  selling: true,
  hidden: hidden
)

traveler_rentals = Shop.find_or_initialize_by(name: 'Traveler Rentals', station: porttressler)
traveler_rentals.update!(
  shop_type: :rental,
  # store_image: Rails.root.join('db/seeds/images/stanton/arccorp/traveler-rentals.jpg').open,
  rental: true,
  hidden: hidden
)


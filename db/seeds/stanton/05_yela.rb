# frozen_string_literal: true

crusader = Planet.find_by!(name: 'Crusader')

yela = Planet.find_or_initialize_by(name: 'Yela')
yela.update!(planet: crusader, store_image: Rails.root.join('db/seeds/images/yela/yela.jpg').open)

grimhex = Station.find_or_initialize_by(name: 'Grimhex')
grimhex.update!(planet: yela, station_type: 'asteroid-station', location: 'Asteroidbelt', store_image: Rails.root.join('db/seeds/images/yela/grimhex.jpg').open)

grimhex.docks.destroy_all
pad = 1
{ small: 3, medium: 2, medium_large: 1 }.each do |ship_size, count|
  count.times do
    grimhex.docks << Dock.new(
      name: "Ladingpad #{"%02d" % pad}",
      dock_type: :landingpad,
      ship_size: ship_size,
    )
    pad += 1
  end
end

grimhex.habitations.destroy_all
%w[A B C D].each do |wing|
  pad = 1
  { container: 8 }.each do |ship_size, count|
    count.times do
      grimhex.habitations << Habitation.new(
        name: "#{wing} #{"%02d" % pad}",
        habitation_type: :container
      )
      pad += 1
    end
  end
end

admin_office = Shop.find_or_create_by(name: 'Admin Office', station: grimhex)
admin_office.update!(shop_type: :admin, store_image: Rails.root.join('db/seeds/images/yela/grimhex_admin.jpg').open)
dumpers_depot = Shop.find_or_create_by(name: "Dumper's Depot", station: grimhex)
dumpers_depot.update!(shop_type: :components, store_image: Rails.root.join('db/seeds/images/yela/grimhex_dumpers.jpg').open)
skutters = Shop.find_or_create_by(name: 'Skutters', station: grimhex)
skutters.update!(shop_type: :armor_and_weapons, store_image: Rails.root.join('db/seeds/images/yela/skutters.jpg').open)
kc_trending = Shop.find_or_create_by(name: 'KC Trending', station: grimhex)
kc_trending.update!(shop_type: :clothing, store_image: Rails.root.join('db/seeds/images/yela/kc_trending.jpg').open)
old_38 = Shop.find_or_create_by(name: "Old '38", station: grimhex)
old_38.update!(shop_type: :bar, store_image: Rails.root.join('db/seeds/images/yela/old_38.jpg').open)

deakins_research_outpost = Station.find_or_initialize_by(name: 'Deakins Research Outpost')
deakins_research_outpost.update!(planet: yela, station_type: :outpost, location: 'Yela', store_image: Rails.root.join('db/seeds/images/yela/deakins_research_outpost.jpg').open)
admin_office = Shop.find_or_create_by(name: 'Admin Office', station: deakins_research_outpost)
admin_office.update!(shop_type: :admin)

deakins_research_outpost.docks.destroy_all
pad = 1
{ small: 2 }.each do |ship_size, count|
  count.times do
    deakins_research_outpost.docks << Dock.new(
      name: "Vehiclepad #{"%02d" % pad}",
      dock_type: :vehiclepad,
      ship_size: ship_size,
    )
    pad += 1
  end
end
pad = 1
{ medium: 1, medium_large: 1 }.each do |ship_size, count|
  count.times do
    deakins_research_outpost.docks << Dock.new(
      name: "Ladingpad #{"%02d" % pad}",
      dock_type: :landingpad,
      ship_size: ship_size,
    )
    pad += 1
  end
end

benson_mining_outpost = Station.find_or_initialize_by(name: 'Benson Mining Outpost')
benson_mining_outpost.update!(planet: yela, station_type: :outpost, location: 'Yela', store_image: Rails.root.join('db/seeds/images/yela/benson_mining.jpg').open)
admin_office = Shop.find_or_create_by(name: 'Admin Office', station: benson_mining_outpost)
admin_office.update!(shop_type: :admin)

arc_corp_mining_area_157 = Station.find_or_initialize_by(name: 'ArcCorp Mining Area 157')
arc_corp_mining_area_157.update!(planet: yela, station_type: :outpost, location: 'Yela', store_image: Rails.root.join('db/seeds/images/yela/arccorp.jpg').open)
admin_office = Shop.find_or_create_by(name: 'Admin Office', station: arc_corp_mining_area_157)
admin_office.update!(shop_type: :admin, store_image: Rails.root.join('db/seeds/images/yela/arccorp_admin.jpg').open)

arc_corp_mining_area_157.docks.destroy_all
pad = 1
{small: 2}.each do |ship_size, count|
  count.times do
    arc_corp_mining_area_157.docks << Dock.new(
      name: "Vehiclepad #{"%02d" % pad}",
      dock_type: :vehiclepad,
      ship_size: ship_size,
    )
    pad += 1
  end
end
pad = 1
{medium_large: 1}.each do |ship_size, count|
  count.times do
    arc_corp_mining_area_157.docks << Dock.new(
      name: "Ladingpad #{"%02d" % pad}",
      dock_type: :landingpad,
      ship_size: ship_size,
    )
    pad += 1
  end
end

nakamura_valley_aid_shelter = Station.find_or_initialize_by(name: 'Nakamura Valley Aid Shelter')
nakamura_valley_aid_shelter.update!(planet: yela, station_type: :outpost, location: 'Yela')
kosso_basin_aid_shelter = Station.find_or_initialize_by(name: 'Kosso Basin Aid Shelter')
kosso_basin_aid_shelter.update!(planet: yela, station_type: :aid_shelter, location: 'Yela')
aston_ridge_aid_shelter = Station.find_or_initialize_by(name: 'Aston Ridge Aid Shelter')
aston_ridge_aid_shelter.update!(planet: yela, station_type: :aid_shelter, location: 'Yela', store_image: Rails.root.join('db/seeds/images/yela/aston_ridge.jpg').open)
talarine_divide_aid_shelter = Station.find_or_initialize_by(name: 'Talarine Divide Aid Shelter')
talarine_divide_aid_shelter.update!(planet: yela, station_type: :aid_shelter, location: 'Yela', store_image: Rails.root.join('db/seeds/images/yela/talarine_divide.jpg').open)



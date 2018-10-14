# frozen_string_literal: true

json.name station.name
json.slug station.slug
json.location station.location
json.type station.station_type
json.type_label station.station_type_label
json.store_image station.store_image.url
json.planet do
  json.partial! 'api/v1/planets/base', planet: station.planet
end
json.starsystem do
  json.partial! 'api/v1/starsystems/base', starsystem: station.starsystem
end
json.shops do
  json.array! station.shops.order(:name), partial: 'api/v1/shops/base', as: :shop
end
json.docks do
  json.array! station.dock_counts, partial: 'api/v1/stations/dock', as: :dock_count
end
json.habitations do
  json.array! station.habitation_counts, partial: 'api/v1/stations/habitation', as: :habitation_count
end

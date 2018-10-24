# frozen_string_literal: true

hurston = CelestialObject.find_by!(slug: 'hurston')
hurston.update!(store_image: Rails.root.join('db/seeds/images/hurston/hurston.png').open)

teasa_spaceport = Station.find_or_initialize_by(name: 'Teasa Spaceport')
teasa_spaceport.update!(celestial_object: hurston, station_type: :spaceport, location: 'Lorville', store_image: Rails.root.join('db/seeds/images/hurston/teasa_spaceport.jpg').open)

new_deal = Shop.find_or_create_by(name: 'New Deal', station: teasa_spaceport)
new_deal.update!(shop_type: :ships)

l19 = Station.find_or_initialize_by(name: 'L19 District')
l19.update!(celestial_object: hurston, station_type: :district, location: 'Lorville', store_image: Rails.root.join('db/seeds/images/hurston/l19.jpg').open)

admin = Shop.find_or_create_by(name: 'Admin', station: l19)
admin.update!(shop_type: :admin)
tammany_and_sons = Shop.find_or_create_by(name: 'Tammany and Sons', station: l19)
tammany_and_sons.update!(shop_type: :superstore, store_image: Rails.root.join('db/seeds/images/hurston/tammany_and_sons.jpg').open)
reclamation_n_disposal = Shop.find_or_create_by(name: 'Reclamation & Disposal', station: l19)
reclamation_n_disposal.update!(shop_type: :salvage, store_image: Rails.root.join('db/seeds/images/hurston/reclamation_n_disposal.jpg').open)
m_n_v = Shop.find_or_create_by(name: 'M & V', station: l19)
m_n_v.update!(shop_type: :bar, store_image: Rails.root.join('db/seeds/images/hurston/m_n_v.jpg').open)
maria_pure_of_heart = Shop.find_or_create_by(name: 'MARIA - Pure of Heart', station: l19)
maria_pure_of_heart.update!(shop_type: :hospital, store_image: Rails.root.join('db/seeds/images/hurston/maria_pure_of_heart.jpg').open)

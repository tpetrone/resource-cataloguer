# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

BasicResource.create(uri: "sbrubles.com")
BasicResource.create(uri: "notsbrubles.com")
BasicResource.create(uri: "maybesbrubles.com")

Capability.create_sensor(name: "temperature")
Capability.create_sensor(name: "air-quality")
Capability.create_sensor(name: "air-humidity")
Capability.create_sensor(name: "parking-occupancy")
Capability.create_sensor(name: "video")
Capability.create_sensor(name: "queue-length")
Capability.create_actuator(name: "semaphore")
Capability.create_information(name: "parking-type")

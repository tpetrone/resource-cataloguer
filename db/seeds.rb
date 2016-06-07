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

Capability.create(name: "temperature", sensor: true)
Capability.create(name: "air-quality", sensor: true)
Capability.create(name: "air-humidity", sensor: true)
Capability.create(name: "parking-occupancy", sensor: true)
Capability.create(name: "video", sensor: true)
Capability.create(name: "queue-length", sensor: true)
Capability.create(name: "semaphore")

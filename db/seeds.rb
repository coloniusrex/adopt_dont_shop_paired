# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shelter.create(name:"Foothills Animals", address:"123 S Whatever St", city:"Centennial", state:"CO", zip:"80122").pets.create(image_url:       "https://images.unsplash.com/photo-1538083156950-7ad24f318e7c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                                                                                                                        name:            "Charlie",
                                                                                                                        description:     "Yello Lab",
                                                                                                                        approximate_age: "6",
                                                                                                                        sex:             "Male",
                                                                                                                        adoptable:       true)
Shelter.create(name:"Rosy Rest", address:"456 S Whichtype St", city:"Englewood", state:"CO", zip:"80122")
Shelter.create(name:"Hidden Valley", address:"123 S Whodid St", city:"Denver", state:"CO", zip:"80122").pets.create(image_url:       "https://images.unsplash.com/photo-1553854201-29e55f0625f7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                                                                                                                        name:            "Moma",
                                                                                                                        description:     "Pug",
                                                                                                                        approximate_age: "2",
                                                                                                                        sex:             "Female",
                                                                                                                        adoptable:       false)

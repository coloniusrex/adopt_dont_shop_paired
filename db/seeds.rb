
shelter1 = Shelter.create(name:"Foothills Animals", address:"123 S Whatever St", city:"Centennial", state:"CO", zip:"80122")

shelter2 = Shelter.create(name:"Rosy Rest", address:"456 S Whichtype St", city:"Englewood", state:"CO", zip:"80122")

shelter3 = Shelter.create(name:"Hidden Valley", address:"123 S Whodid St", city:"Denver", state:"CO", zip:"80122")

pet1 = shelter1.pets.create(image_url:       "https://images.unsplash.com/photo-1453227588063-bb302b62f50b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                            name:            "Moma",
                            description:     "Pug",
                            approximate_age: "2",
                            sex:             "Female",
                            adoptable:       true)

pet2 = shelter1.pets.create(image_url:       "https://images.unsplash.com/photo-1516598540642-e8f40a09d939?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80",
                            name:            "Charlie",
                            description:     "Yello Lab",
                            approximate_age: "6",
                            sex:             "Male",
                            adoptable:       true)

pet3 = shelter2.pets.create(image_url:       "https://images.unsplash.com/photo-1529158299404-547993c51cc7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                            name:            "Samson",
                            description:     "Boxer",
                            approximate_age: "6",
                            sex:             "Male",
                            adoptable:       true)

pet4 = shelter2.pets.create(image_url:       "https://images.unsplash.com/flagged/photo-1561023368-a605b6849234?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1953&q=80",
                            name:            "Starlight",
                            description:     "Starfish",
                            approximate_age: "100",
                            sex:             "Female",
                            adoptable:       true)

pet5 = shelter3.pets.create(image_url:       "https://images.unsplash.com/photo-1543055484-ac8fe612bf31?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                            name:            "Felix",
                            description:     "Maine Coon",
                            approximate_age: "4",
                            sex:             "Female",
                            adoptable:       true)

pet6 = shelter3.pets.create(image_url:       "https://images.unsplash.com/photo-1516280030429-27679b3dc9cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                            name:            "Meatball",
                            description:     "Barn Cat",
                            approximate_age: "2",
                            sex:             "Male",
                            adoptable:       true)

shelter1.reviews.create(title:    'Greate Shelter',
                                    rating:   5,
                                    content:  'Outstanding, knowledgable and friendly staff.')

shelter1.reviews.create(title:    'It\'s OK',
                                    rating:   3,
                                    content:  'I felt as the staff was a little standoff-ish. Maybe I just met them on a bad day.')

shelter2.reviews.create(title:    'Love It',
                                    rating:   4,
                                    content:  'The shelter was a bit dirty but they took such good care of the animals.')

shelter2.reviews.create(title:    'Love It',
                                    rating:   4,
                                    content:  'The shelter was a bit dirty but they took such good care of the animals.')

shelter3.reviews.create(title:    'It Sucks',
                                    rating:   1,
                                    content:  'This place is dirty and the people are mean, don\'t come here!!')

application1 = AdoptionApp.create(name:"Ryan",
                                address: "23 Cedarwood Road",
                                city: "Omaha",
                                state: "NE",
                                zip: "68107",
                                phone_number: "456-908-7656",
                                description: "I am a good pet owner")

application2 = AdoptionApp.create(name:"Colin",
                                address: "8397 Mayfair Lane",
                                city: "Chevy Chase",
                                state: "MD",
                                zip: "20815",
                                phone_number: "303-675-0987",
                                description: "I am the best pet owner")

application1.process([pet1.id, pet2.id, pet3.id, pet6.id])
application2.process([pet4.id, pet2.id, pet5.id, pet6.id])

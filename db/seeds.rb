# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
RandomCharacter.destroy_all
RandomCharacter.create([{name: 'Gary', gender: 'male'},
  {name: 'Rebecca', gender: 'female'},{name: 'Andrew', gender: 'male'},
  {name: 'the dragon', gender: 'female'},{name: 'the dog', gender: 'male'},
  {name: 'the horse', gender: 'male'},{name: 'the cat', gender: 'female'},
  {name: 'the zebra', gender: 'female'},{name: 'the rhino', gender: 'female'},
  {name: 'the teacher', gender: 'male'},{name: 'Mr. Smith', gender: 'male'},
  {name: 'Mrs. Roberts', gender: 'female'},{name: 'Anthony', gender: 'male'},
  {name: 'Amanda', gender: 'female'},{name: 'Bob', gender: 'male'},
  {name: 'Freddy', gender: 'male'},{name: 'the hen', gender: 'female'},
  {name: 'the rooster', gender: 'male'},{name: 'Gretchen', gender: 'female'},
  {name: 'Doug', gender: 'male'},{name: 'Mickey', gender: 'male'},
  {name: 'the pug', gender: 'female'},{name: 'the dachshund', gender: 'female'},
  {name: 'Oscar', gender: 'male'},{name: 'Betsy', gender: 'female'},
  {name: 'Michael', gender: 'male'},{name: 'Katy', gender: 'female'},
  {name: 'Josh', gender: 'male'},{name: 'Kaylee', gender: 'female'},
  {name: 'Nathan', gender: 'male'},{name: 'Jessica', gender: 'female'},
  {name: 'Seth', gender: 'male'},{name: 'Paige', gender: 'female'},
  {name: 'Ross', gender: 'male'},{name: 'Jen', gender: 'female'},
  {name: 'the shark', gender: 'male'},{name: 'the fish', gender: 'female'},
  {name: 'the dinosaur', gender: 'male'},{name: 'the mammoth', gender: 'female'},
  {name: 'the sloth', gender: 'male'},{name: 'the unicorn', gender: 'female'},
  {name: 'Mr. Anderson', gender: 'male'},{name: 'Mrs. Carter', gender: 'female'},
  {name: 'Mr. Jones', gender: 'male'},{name: 'Mrs. Kennedy', gender: 'female'},
  {name: 'Adam', gender: 'male'},{name: 'the tiger', gender: 'female'},
  {name: 'the hippo', gender: 'male'},{name: 'the flamingo', gender: 'female'},
  {name: 'Abigail', gender: 'female'}])
p "Created #{RandomCharacter.count} random characters"
RandomItem.destroy_all
RandomItem.create([{name: 'a sword'},{name: 'a gun'},{name: 'a knife'},
  {name: 'a football'},{name: 'a basketball'},{name: 'a banana'},
  {name: 'a cake'},{name: 'a cupcake'},{name: 'a pie'},
  {name: 'a pizza'},{name: 'a shoe'},{name: 'a boot'},
  {name: 'a chair'},{name: 'a photograph'},{name: 'a journal'},
  {name: 'a diary'},{name: 'a piece of paper'},{name: 'an apple'},
  {name: 'a hatchet'},{name: 'a rocket launcher'},{name: 'a grenade'},
  {name: 'a toy gun'},{name: 'a lemon'},{name: 'a pickle'},
  {name: 'a toy soldier'},{name: 'a chess piece'},{name: 'a bandage'},
  {name: 'a camera'},{name: 'a television'},{name: 'the Holy Bible'},
  {name: 'a dictionary'},{name: 'a letter opener'},{name: 'a book'},
  {name: 'a pair of pants'},{name: 'a t-shirt'},{name: 'a stool'},
  {name: 'a katana'},{name: 'nunchucks'},{name: 'a guitar'},
  {name: 'a drill'},{name: 'a lego piece'},{name: 'a piece of candy'},
  {name: 'a rifle'},{name: 'a fire hydrant'},{name: 'a flip flop'},
  {name: 'a roll of toilet paper'},{name: 'a comb'},{name: 'a clothes iron'},
  {name: 'a deck of cards'},{name: 'a roll of duct tape'}])
p "Created #{RandomItem.count} random items"
RandomPlace.destroy_all
RandomPlace.create([{name: 'Canada'},{name: 'Idaho'},{name: 'Illinois'},
  {name: 'Venus'},{name: 'Mars'},{name: 'Mercury'},
  {name: 'the Sun'},{name: 'Saturn'},{name: 'the kitchen'},
  {name: 'the basement'},{name: 'the study'},{name: 'the dining room'},
  {name: 'Neptune'},{name: 'Indiana'},{name: 'California'},
  {name: 'Colorado'},{name: 'Iowa'},{name: 'Mexico'},
  {name: 'Florida'},{name: 'New York'},{name: 'the public library'},
  {name: 'the bathroom'},{name: 'the garage'},{name: 'the park'},
  {name: 'the mall'},{name: 'the movie theater'},{name: 'the back yard'},
  {name: 'the abandoned alley'},{name: 'the front porch'},{name: 'the street'},
  {name: 'Kentucky'},{name: 'Illinois'},{name: 'Ohio'},
  {name: 'Utah'},{name: 'Nevada'},{name: 'China'},
  {name: 'Beijing'},{name: 'the ocean'},{name: 'the bottom of the sea'},
  {name: 'Hawaii'},{name: 'the Philippines'},{name: 'Madagascar'},
  {name: 'New Zealand'},{name: 'the bank'},{name: 'the Mississippi river'},
  {name: 'the zoo'},{name: 'the haunted mansion'},{name: 'the grand ballroom'},
  {name: 'the billiards room'},{name: 'the magic castle'}])
p "Created #{RandomPlace.count} random places"

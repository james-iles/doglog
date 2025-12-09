# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Clearing old data..."
User.destroy_all
Household.destroy_all
Dog.destroy_all
Appointment.destroy_all
Document.destroy_all

puts "Adding new seed data..."
puts "Creating 1 household..."
household = Household.create!(name: "Castelo Dias")

puts "Creating 3 users..."
user1 = User.create!(
  email: "james@email.com",
  household: household,
  password: "password"
  )

user2 = User.create!(
  email: "feri@email.com",
  household: household,
  password: "password"
  )

user3 = User.create!(
  email: "joao@email.com",
  household: household,
  password: "password"
  )

puts "Creating 2 dogs..."
dog1 = Dog.create!(
  name: "Benson",
  breed: "Labrador Retriever",
  dob: Date.new(2025, 4, 14),
  household: household
  )

dog2 = Dog.create!(
  name: "Rex",
  breed: "German Shepherd",
  dob: Date.new(2021, 8, 22),
  household: household
  )

puts "Creating 2 appointments..."
Appointment.create!(
  date: Date.new(2026, 2, 9),
  appointment_type: "Pet Sitting",
  location: "Mum and Dad's House",
  appointment_notes: "",
  host: "Mum and Dad",
  dog: dog2
  )

Appointment.create!(
  date: Date.new(2025, 12, 30),
  appointment_type: "Vet Checkup",
  location: "Oldfield Park, Bath",
  appointment_notes: "Remember to bring his old medication",
  host: "Vets for Pets",
  dog: dog2
  )

puts "Creating 6 documents..."
Document.create!(
  title: "Vaccination Certificate",
  content: "Core vaccines completed at 12 months. DHPP, Lepto 4, and Kennel Cough all up to date. Next booster due: 14 May 2025.",
  category: "Medical",
  dog: dog1,
  )

Document.create!(
  title: "Vet notes from September",
  content: "Just routine. Asked about irritation in left ear; advised regular cleaning with recommended solution. Weight: 24.3kg.",
  category: "Medical",
  dog: dog1,
  )

Document.create!(
  title: "Dog walker contact details",
  content: "Name: Chloe Barnett\nPhone: 07892 441 118\nWalks on Tuesdays and Thursdays at 12-1pm.",
  category: "Contact Information",
  dog: dog1,
  )

Document.create!(
  title: "Pet Insurance Policy",
  content: "Provider: PetSure Premium. Policy No: PS-3948221. Coverage includes accidents, illness, and dental up to £8,000 per year. Excess: £85. Claims must be submitted within 60 days of treatment. Policy active until 30 Nov 2025.",
  category: "Legal",
  dog: dog1,
  )

Document.create!(
  title: "Pet Insurance Renewal",
  content: "Renewal date: 30 Nov 2025. New premium quoted at £41.60/month (up from £38.20). Option to add physiotherapy coverage for an additional £4.80. No changes in pre-existing condition rules.",
  category: "Legal",
  dog: dog2,
  )

Document.create!(
  title: "Summary of your 'strange Limp' chat",
  content: "Intermittent limp after long walks. No swelling or heat detected. Suggested reducing high-impact activity for 5–7 days and monitoring for any worsening. If limp persists, book a physical exam with a medical professional for further assessment.",
  category: "Chat Summaries",
  dog: dog2,
  )

puts "Seeding complete!"

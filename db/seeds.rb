# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Clearing old data..."
Chat.destroy_all
Message.destroy_all
Document.destroy_all
Appointment.destroy_all
Dog.destroy_all
User.destroy_all
Household.destroy_all

puts "Adding new seed data..."
puts "Creating 1 household..."
household = Household.create!(
  name: "The Poodle Palace",
  owner_name: "James Iles",
  email: "james@email.com",
  phone: "07700 900123"
)

puts "Creating 3 users..."
user1 = User.create!(
  email: "james@email.com",
  household: household,
  password: "password"
)

user2 = User.create!(
  email: "joao@fastmail.com",
  household: household,
  password: "password"
)

puts "Creating 2 dogs..."
dog1 = Dog.create!(
  name: "Thor",
  breed: "Miniature Poodle",
  dob: Date.new(2024, 4, 14),
  household: household,
  gender: "Male",
  weight: 12.3,
  vet_name: "Dr. Sarah Mitchell",
  vet_clinic: "Vets4Pets Bath",
  vet_phone: "01225 234567",
  vet_address: "12 High Street, Bath, BA1 2QP",
  insurance_provider: "PetSure Premium",
  insurance_policy_number: "PS-3948221",
  microchip_number: "941000024681357",
  allergies: "Chicken, Grass, Cats",
  medications: nil,
  special_notes: "Loves squeaky toys. Gets anxious during thunderstorms and is super reactive to the uncle Steve's Rottweiler"
)

dog2 = Dog.create!(
  name: "Karen",
  breed: "German Shepherd",
  dob: Date.new(2021, 8, 22),
  household: household,
  gender: "Female",
  weight: 32.5,
  vet_name: "Dr. Michael Chen",
  vet_clinic: "Oldfield Veterinary Practice",
  vet_phone: "01225 876543",
  vet_address: "45 Oldfield Park, Bristol, BS1 3NR",
  insurance_provider: "Petplan",
  insurance_policy_number: "PP-8827364",
  microchip_number: "941000098765432",
  allergies: nil,
  medications: "Glucosamine supplement daily",
  special_notes: "Very protective. Needs slow introductions to new people."
)

puts "Creating appointments..."
Appointment.create!(
  title: "Annual Vaccination Booster",
  appointment_type: "Veterinarian",
  location: "Vets4Pets Bath, 12 High Street, Bath",
  appointment_notes: "Bring vaccination card. Due for DHPP and Lepto 4.",
  host: "Dr. Sarah Mitchell",
  dog: dog1,
  start_time: 3.days.from_now.change(hour: 10, min: 30),
  end_time: 3.days.from_now.change(hour: 11, min: 0)
)

Appointment.create!(
  title: "Weekly Groom Session",
  appointment_type: "Treeming",
  location: "Pampered Paws, 8 Widcombe Parade, Bath",
  appointment_notes: "Full groom - bath, nail trim, ear cleaning",
  host: "Gemma at Pampered Paws",
  dog: dog1,
  start_time: 5.days.from_now.change(hour: 14, min: 0),
  end_time: 5.days.from_now.change(hour: 15, min: 30)
)

Appointment.create!(
  title: "Morning Walk with Chloe",
  appointment_type: "Dogwalker",
  location: "Royal Victoria Park, Bath",
  appointment_notes: "1 hour group walk. Harness is in the hallway cupboard.",
  host: "Chloe Barnett",
  dog: dog1,
  start_time: 2.days.from_now.change(hour: 12, min: 0),
  end_time: 2.days.from_now.change(hour: 13, min: 0)
)

Appointment.create!(
  title: "Hip X-Ray Follow-up",
  appointment_type: "Veterinarian",
  location: "Oldfield Veterinary Practice, 45 Oldfield Park, Bath",
  appointment_notes: "Review hip x-ray results. Discuss long-term joint care plan.",
  host: "Dr. Michael Chen",
  dog: dog2,
  start_time: 1.week.from_now.change(hour: 9, min: 0),
  end_time: 1.week.from_now.change(hour: 9, min: 30)
)

Appointment.create!(
  title: "Playdate with Bruno",
  appointment_type: "Playdate",
  location: "Alice Park, Larkhall",
  appointment_notes: "Meeting Sarah and Bruno. Both dogs get along well.",
  host: "Sarah Thompson",
  dog: dog2,
  start_time: 4.days.from_now.change(hour: 16, min: 0),
  end_time: 4.days.from_now.change(hour: 17, min: 30)
)

Appointment.create!(
  title: "Pet Sitting at Parents",
  appointment_type: "Other",
  location: "Mum and Dad's House, Bristol",
  appointment_notes: "Drop off on Friday evening, pick up Sunday afternoon. Bring his bed and blanket.",
  host: "Mum and Dad",
  dog: dog2,
  start_time: 2.weeks.from_now.change(hour: 18, min: 0),
  end_time: (2.weeks.from_now + 2.days).change(hour: 15, min: 0)
)

# Additional appointments for Thor
Appointment.create!(
  title: "Puppy Socialisation Class",
  appointment_type: "Other",
  location: "Bath Dog Training Club, Claverton Down",
  appointment_notes: "Week 4 of 6. Working on greeting other dogs calmly. Bring high-value treats.",
  host: "Mark Williams",
  dog: dog1,
  start_time: 6.days.from_now.change(hour: 18, min: 30),
  end_time: 6.days.from_now.change(hour: 19, min: 30)
)

Appointment.create!(
  title: "Dental Check",
  appointment_type: "Veterinarian",
  location: "Vets4Pets Bath, 12 High Street, Bath",
  appointment_notes: "Routine dental examination. Vet nurse mentioned possible tartar buildup at last visit.",
  host: "Nurse Jenny",
  dog: dog1,
  start_time: 10.days.from_now.change(hour: 11, min: 0),
  end_time: 10.days.from_now.change(hour: 11, min: 30)
)

# Additional appointments for Karen
Appointment.create!(
  title: "Hydrotherapy Session",
  appointment_type: "Other",
  location: "Canine Aqua Centre, Keynsham",
  appointment_notes: "First hydrotherapy session for joint support. Bring towels and treats. No food 2 hours before.",
  host: "Lisa at Canine Aqua",
  dog: dog2,
  start_time: 8.days.from_now.change(hour: 14, min: 0),
  end_time: 8.days.from_now.change(hour: 15, min: 0)
)

Appointment.create!(
  title: "Evening Walk with Pack",
  appointment_type: "Dogwalker",
  location: "Prior Park, Bath",
  appointment_notes: "Group walk with 3 other dogs. Karen knows them all. Muzzle not required.",
  host: "Tom's Dog Walking",
  dog: dog2,
  start_time: 3.days.from_now.change(hour: 17, min: 0),
  end_time: 3.days.from_now.change(hour: 18, min: 30)
)

puts "Creating documents..."
# Medical documents
Document.create!(
  title: "Vaccination Certificate",
  content: "Core vaccines completed. DHPP, Lepto 4, and Kennel Cough all up to date.\n\nVaccination Schedule:\n- DHPP: 14 Apr 2024 (next due: 14 Apr 2025)\n- Leptospirosis: 14 Apr 2024 (next due: 14 Apr 2025)\n- Kennel Cough: 14 Oct 2024 (next due: 14 Oct 2025)\n\nAdministered by: Dr. Sarah Mitchell, Vets4Pets Bath",
  category: "Medical",
  dog: dog1
)

Document.create!(
  title: "Routine Checkup Notes - September 2024",
  content: "Weight: 24.3kg (healthy range)\n\nExamination findings:\n- Heart and lungs: Normal\n- Teeth: Minor tartar buildup, recommend dental chews\n- Ears: Slight irritation in left ear, advised regular cleaning with Epi-Otic solution\n- Joints: Good mobility, no concerns\n\nRecommendations:\n- Continue current diet\n- Daily ear cleaning for 2 weeks\n- Schedule dental cleaning in next 6 months",
  category: "Medical",
  dog: dog1
)

Document.create!(
  title: "Hip Dysplasia Diagnosis",
  content: "Date: 15 November 2024\n\nDiagnosis: Mild bilateral hip dysplasia\n\nX-ray findings show early signs of hip joint looseness. Currently Grade 1 (mild).\n\nTreatment Plan:\n- Daily glucosamine/chondroitin supplement (started)\n- Maintain healthy weight (current: 32.5kg, ideal: 30-33kg)\n- Avoid high-impact activities (no excessive jumping)\n- Swimming recommended for low-impact exercise\n- Follow-up x-ray in 6 months\n\nPrognosis: Good with proper management. Many dogs live comfortably with mild dysplasia.",
  category: "Medical",
  dog: dog2
)

# Training documents
Document.create!(
  title: "Puppy Training Class Certificate",
  content: "Certificate of Completion\n\nBenson has successfully completed the 6-week Puppy Foundation Course at Bath Dog Training Club.\n\nSkills achieved:\n- Sit, down, stay (30+ seconds)\n- Loose lead walking\n- Recall in low-distraction environments\n- Crate training fundamentals\n- Polite greetings\n\nTrainer: Mark Williams\nDate: 15 June 2023\n\nRecommendation: Progress to Intermediate Obedience class",
  category: "Training",
  dog: dog1
)

Document.create!(
  title: "Reactivity Training Notes",
  content: "Working with behaviourist Emma Scott on lead reactivity.\n\nTriggers identified:\n- Other dogs approaching head-on\n- Cyclists moving quickly\n- People with hats/hoods\n\nTechniques being used:\n- Look At That (LAT) game\n- Emergency U-turns\n- Threshold management\n- High-value treats (cheese, chicken)\n\nProgress after 4 sessions:\n- Threshold distance reduced from 20m to 10m for dogs\n- Successfully ignored 3 cyclists last week\n- Still reactive to hooded figures\n\nNext session: Focus on counter-conditioning with strangers",
  category: "Behavior",
  dog: dog2
)

# Grooming document
Document.create!(
  title: "Grooming Schedule & Notes",
  content: "Regular grooming routine:\n\n- Brushing: Daily (5-10 mins) - using slicker brush\n- Baths: Every 4-6 weeks or as needed\n- Nail trim: Every 3-4 weeks\n- Ear cleaning: Weekly (use Epi-Otic)\n- Teeth brushing: Daily with enzymatic toothpaste\n\nGroomer: Pampered Paws, Widcombe\nAppointment frequency: Every 6 weeks\nCost: 45 per session\n\nNotes: Doesn't like having back feet handled - go slowly. Loves the dryer!",
  category: "Grooming",
  dog: dog1
)

# Nutrition document
Document.create!(
  title: "Diet & Feeding Guide",
  content: "Current Food: Orijen Original Adult\n\nDaily Amount: 350g (split into 2 meals)\n- Morning: 175g at 7:30am\n- Evening: 175g at 6:00pm\n\nSupplements:\n- Salmon oil: 1 pump daily (for coat health)\n- Glucosamine: 1 tablet daily (for joints)\n\nTreats (max 10% of daily calories):\n- Training: Small pieces of cheese or chicken\n- Dental chews: 1 Whimzee per day\n\nFoods to avoid:\n- Chicken (allergy)\n- Grapes, raisins, chocolate, onions, garlic\n\nWater: Fresh water always available, drinks approx 1L daily",
  category: "Nutrition",
  dog: dog2
)

# Appointment-related document
Document.create!(
  title: "Vet Appointment Preparation Checklist",
  content: "Things to bring to vet appointments:\n\n- Vaccination card/pet passport\n- List of current medications and supplements\n- Any recent symptom notes\n- Favourite treats for positive association\n- Muzzle (if needed - Rex only)\n- Poo bag in case of nervous accidents\n\nQuestions to ask:\n- Weight check and body condition score\n- Any concerns about diet or behaviour\n- Parasite prevention up to date?\n- Microchip details still correct?",
  category: "Appointment",
  dog: dog1
)

# Additional documents for Thor
Document.create!(
  title: "Emergency Contact Information",
  content: "Primary Emergency Vet:\nBath Veterinary Emergency Clinic\n24 Hour Line: 01225 999888\nAddress: 78 Lower Bristol Road, Bath BA2 3BQ\n\nPoison Control:\nAnimal PoisonLine: 01onal 202 509 000\nAvailable 24/7 - charge applies\n\nBackup Care Contacts:\n1. Sarah Thompson - 07700 123456 (neighbour, has key)\n2. Mum and Dad - 01225 456789 (can collect within 1 hour)\n\nInsurance Emergency Line:\nPetSure Premium: 0800 123 4567\nPolicy: PS-3948221",
  category: "Other",
  dog: dog1
)

Document.create!(
  title: "Flea & Worm Treatment Schedule",
  content: "Current Products:\n- Flea/Tick: NexGard Spectra (monthly chewable)\n- Wormer: Included in NexGard Spectra\n\nTreatment Log:\n- Nov 2024: Given 1st of month\n- Dec 2024: Given 1st of month\n- Jan 2025: Due 1st of month\n\nWeight-based dosage: 12.3kg = Medium dog size\n\nNotes:\n- Give with food for best absorption\n- Watch for any vomiting in first 24 hours\n- Purchased from Vets4Pets (prescription required)",
  category: "Medical",
  dog: dog1
)

# Additional documents for Karen
Document.create!(
  title: "Joint Care Management Plan",
  content: "Following hip dysplasia diagnosis - November 2024\n\nDaily Routine:\n- Morning: 20-30 min gentle walk on flat terrain\n- Afternoon: Rest period, avoid stairs where possible\n- Evening: 20-30 min walk, swimming if available\n\nSupplements (daily):\n- Glucosamine: 1500mg\n- Chondroitin: 1200mg\n- Fish oil: 1000mg (omega-3 for inflammation)\n\nWeight Management:\n- Target weight: 30-32kg\n- Current: 32.5kg - maintain or slight reduction\n- Measured feeding only, no free feeding\n\nWarning Signs to Watch:\n- Increased stiffness\n- Reluctance to climb/jump\n- Bunny hopping gait\n- Muscle wasting in hind legs",
  category: "Medical",
  dog: dog2
)

Document.create!(
  title: "Introduction Protocol for New People",
  content: "Karen requires careful introductions due to her protective nature.\n\nStep 1: Initial Meeting\n- Meet outdoors in neutral territory\n- Handler should remain calm and relaxed\n- New person should avoid direct eye contact initially\n- No sudden movements or loud voices\n\nStep 2: Treat Association\n- New person tosses treats (don't hand feed yet)\n- Let Karen approach at her own pace\n- Sessions should be short (5-10 mins)\n\nStep 3: Building Trust\n- Multiple short sessions over several days\n- Progress to hand feeding treats\n- Avoid reaching over her head\n- Let her initiate contact\n\nRed Flags (end session immediately):\n- Hackles raised\n- Stiff body posture\n- Hard stare\n- Low growling\n\nNotes: Usually takes 2-3 meetings before she's comfortable. Once bonded, she's extremely loyal and affectionate.",
  category: "Behavior",
  dog: dog2
)

puts "Creating chat summaries..."
# Chat 1 for dog1
chat1 = Chat.create!(
  title: "Ear Infection Symptoms",
  dog: dog1
)

Message.create!(
  chat: chat1,
  role: "user",
  content: "Benson keeps scratching his left ear and shaking his head. There's also a bit of a smell. Is this something I should worry about?"
)

Message.create!(
  chat: chat1,
  role: "assistant",
  content: "Based on what you're describing - scratching, head shaking, and odour - these are classic signs of an ear infection in dogs. Labradors like Benson are particularly prone to ear infections due to their floppy ears which trap moisture.\n\nI'd recommend:\n1. Gently check the ear for redness, swelling, or discharge\n2. Don't insert anything into the ear canal\n3. Book a vet appointment within the next day or two\n\nIn the meantime, you can gently clean the outer ear with a dog-safe ear cleaner if you have one. The vet will likely prescribe ear drops and possibly oral antibiotics depending on the severity.\n\nIs there any discharge visible, and what colour is it?"
)

Message.create!(
  chat: chat1,
  role: "user",
  content: "There's some brown waxy stuff when I look inside. It does look quite red too."
)

Message.create!(
  chat: chat1,
  role: "assistant",
  content: "Brown waxy discharge combined with redness and odour strongly suggests a yeast infection (Malassezia), which is very common in dogs, especially breeds with floppy ears. The good news is these respond well to treatment.\n\nI'd recommend booking an appointment with Dr. Sarah Mitchell at Vets4Pets this week. They'll likely:\n- Take a swab to confirm the type of infection\n- Prescribe antifungal ear drops (typically used for 7-14 days)\n- Show you how to properly clean and apply the medication\n\nUntil then, try to stop Benson from scratching (an e-collar might help if it's severe) as this can make the irritation worse. Don't use any home remedies like vinegar - these can be painful on inflamed ears."
)

# Chat 2 for dog2
chat2 = Chat.create!(
  title: "Limping After Walks",
  dog: dog2
)

Message.create!(
  chat: chat2,
  role: "user",
  content: "Rex has been limping a bit after our longer walks lately. It seems to go away after he rests but I'm worried. He's 3 and a half now."
)

Message.create!(
  chat: chat2,
  role: "assistant",
  content: "Intermittent limping that improves with rest is worth investigating, especially in German Shepherds who are prone to hip and joint issues. Given Rex's age (3.5 years) and breed, this could be early signs of:\n\n1. Hip dysplasia (common in GSDs)\n2. Soft tissue strain from overexertion\n3. Early arthritis\n4. Paw pad injury\n\nCan you tell me:\n- Which leg(s) does he favour?\n- How long are your 'longer walks'?\n- Does he seem stiff when first getting up?\n- Have you noticed any changes to his gait?"
)

Message.create!(
  chat: chat2,
  role: "user",
  content: "It seems to be his back legs, both of them really. Our long walks are about 2 hours. He does seem a bit stiff in the mornings now that you mention it."
)

Message.create!(
  chat: chat2,
  role: "assistant",
  content: "The combination of bilateral hind leg stiffness, symptoms after extended exercise, and morning stiffness does raise concern for hip dysplasia, which unfortunately is very common in German Shepherds.\n\nI strongly recommend:\n1. **Book a vet appointment soon** - Dr. Chen can do a physical exam and likely recommend hip x-rays\n2. **Reduce walk duration** - Switch to 2-3 shorter walks (30-45 mins) instead of one long one\n3. **Avoid high-impact activity** - No ball chasing, jumping, or rough play for now\n4. **Consider joint supplements** - Glucosamine/chondroitin can help, but check with your vet first\n\nThe good news is that if caught early, hip dysplasia can be managed very effectively. Many dogs live comfortable, active lives with proper management including weight control, appropriate exercise, supplements, and sometimes anti-inflammatories.\n\nWould you like me to save a note about these symptoms to show the vet?"
)

puts "Seeding complete!"
puts "Created: 1 household, 2 users, 2 dogs, 10 appointments, 12 documents, 2 chats"

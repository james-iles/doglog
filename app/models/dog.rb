class Dog < ApplicationRecord
  belongs_to :household
  has_many :documents, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :shareable_profiles, dependent: :destroy

  has_one_attached :photo
  validates :name, presence: true, length: { minimum: 2, maximum: 10 }
  validates :breed, presence: true, inclusion: { in: BREEDS, message: "%{value} is not a valid breed" }

  validates :dob, presence: true
  validates :household_id, presence: true

  BREEDS = [
  'Labrador Retriever', 'Golden Retriever', 'English Springer Spaniel',
  'Cocker Spaniel', 'German Shorthaired Pointer', 'Brittany',
  'Vizsla', 'Weimaraner', 'Irish Setter', 'English Setter',
  'Chesapeake Bay Retriever', 'Pointer', 'Flat-Coated Retriever',
  'Nova Scotia Duck Tolling Retriever', 'Spinone Italiano',
  'Beagle', 'Bloodhound', 'Dachshund', 'Basset Hound',
  'Greyhound', 'Whippet', 'Afghan Hound', 'Rhodesian Ridgeback',
  'Irish Wolfhound', 'Saluki', 'Basenji', 'American Foxhound',
  'English Foxhound', 'Coonhound', 'Scottish Deerhound',
  'Borzoi', 'Pharaoh Hound',
  'German Shepherd', 'Siberian Husky', 'Alaskan Malamute',
  'Boxer', 'Great Dane', 'Rottweiler', 'Doberman Pinscher',
  'Saint Bernard', 'Bernese Mountain Dog', 'Mastiff',
  'Bullmastiff', 'Newfoundland', 'Great Pyrenees', 'Akita',
  'Samoyed', 'Portuguese Water Dog', 'Standard Schnauzer',
  'Giant Schnauzer',
  'Bull Terrier', 'American Staffordshire Terrier',
  'Staffordshire Bull Terrier', 'Jack Russell Terrier',
  'Parson Russell Terrier', 'Scottish Terrier',
  'West Highland White Terrier', 'Airedale Terrier',
  'Wire Fox Terrier', 'Smooth Fox Terrier', 'Yorkshire Terrier',
  'Cairn Terrier', 'Border Terrier', 'Australian Terrier',
  'Irish Terrier', 'Miniature Schnauzer', 'Soft Coated Wheaten Terrier',
  'Chihuahua', 'Pomeranian', 'Pug', 'Shih Tzu', 'Maltese',
  'Cavalier King Charles Spaniel', 'Pekingese', 'Papillon',
  'Italian Greyhound', 'Toy Poodle', 'Havanese',
  'Brussels Griffon', 'Chinese Crested', 'Japanese Chin',
  'Affenpinscher', 'Toy Fox Terrier',
  'Bulldog', 'English Bulldog', 'French Bulldog',
  'Standard Poodle', 'Miniature Poodle', 'Dalmatian',
  'Boston Terrier', 'Chow Chow', 'Bichon Frise',
  'Shar-Pei', 'Shiba Inu', 'Lhasa Apso', 'Finnish Spitz',
  'Keeshond', 'Schipperke', 'Tibetan Spaniel', 'Tibetan Terrier',
  'Border Collie', 'Australian Shepherd', 'Pembroke Welsh Corgi',
  'Cardigan Welsh Corgi', 'Shetland Sheepdog', 'Collie',
  'Belgian Malinois', 'Belgian Tervuren', 'Belgian Sheepdog',
  'Australian Cattle Dog', 'Old English Sheepdog',
  'Bearded Collie', 'Puli', 'Briard', 'Bouvier des Flandres'
].freeze

def age_in_years
  return nil unless dob
  ((Time.current - dob.to_time) / 1.year.seconds).floor
end

def age_in_months
  return nil unless dob
  months_between(Date.today, dob)
end

def current_share_profile
  shareable_profiles.active.order(created_at: :desc).first
end

def profile_data_for(categories)
  data = {}

  categories.each do |category|
    case category
    when 'owner_details'
      data[:owner] = {
      name: household.owner_name,
      email: household.email,
      phone: household.phone
    }
  when 'vet_details'
    data[:vet] = {
    name: vet_name,
    clinic: vet_clinic,
    phone: vet_phone,
    address: vet_address
  }
when 'medical_info'
  data[:medical] = {
  allergies: allergies,
  medications: medications,
  microchip: microchip_number,
  special_notes: special_notes,
  documents: documents.where(category: 'Medical').pluck(:title, :content)
}
when 'training_commands'
  data[:training] = {
  documents: documents.where(category: 'Training').pluck(:title, :content)
}
when 'insurance'
  data[:insurance] = {
  provider: insurance_provider,
  policy_number: insurance_policy_number
}
end
end

data
end

private

def months_between(date1, date2)
  (date1.year * 12 + date1.month) - (date2.year * 12 + date2.month)
end

end

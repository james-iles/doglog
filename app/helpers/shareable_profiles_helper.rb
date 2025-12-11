# app/helpers/shareable_profiles_helper.rb
module ShareableProfilesHelper
  def icon_for_category(category)
    icons = {
      'owner_details' => 'person-circle',
      'vet_details' => 'hospital',
      'medical_info' => 'heart-pulse',
      'training_commands' => 'award',
      'insurance' => 'shield-check'
    }
    icons[category] || 'circle'
  end
end

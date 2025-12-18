module DocumentsHelper
  def category_icon(category)
    icons = {
      "Medical" => "fa-solid fa-heart-pulse",
      "Training" => "fa-solid fa-graduation-cap",
      "Grooming" => "fa-solid fa-scissors",
      "Nutrition" => "fa-solid fa-bowl-food",
      "Behavior" => "fa-solid fa-brain",
      "Appointment" => "fa-solid fa-calendar-check",
      "Chat" => "fa-solid fa-comment",
      "Other" => "fa-solid fa-folder"
    }
    icons[category] || "fa-solid fa-file"
  end
end

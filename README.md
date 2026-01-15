# DogLog

A comprehensive dog profile manager with AI-powered pet care assistance and secure sharing features.

## What it does

DogLog helps dog owners keep all their pet's important information in one place—medical records, vet details, appointments, training notes, and more. Chat with an AI assistant for dog care advice, and securely share your dog's profile with vets, sitters, or emergency contacts via PIN-protected links.

## Features

- Complete dog profiles with medical history, vet info, and insurance details
- AI-powered chat assistant for dog care, health, and training advice
- Appointment tracking for vet visits, grooming, walks, and playdates
- Document storage organized by category (medical, training, nutrition, behavior)
- Secure profile sharing with PIN protection, expiration dates, and QR codes
- Multi-dog household support for families with multiple pets

## Tech Stack

- **Backend:** Ruby on Rails 7.1, Ruby 3.3.5
- **Database:** PostgreSQL
- **AI:** RubyLLM (OpenAI)
- **Images:** Cloudinary
- **Frontend:** Bootstrap 5, Turbo, Stimulus
- **Auth:** Devise

## Setup

```bash
# Install dependencies
bundle install

# Setup database
rails db:create db:migrate

# Add your API keys to .env
OPENAI_API_KEY=your_key
CLOUDINARY_URL=your_cloudinary_url

# Start the server
rails server
```

## Team

Built by **Ferizzat Jussupbekova**, **Joao Dias**, and **James Iles**.

Product Manager: James Iles

## Deployment

This app is deployed on Render using a PostgreSQL database.
Secrets are managed via environment variables.

---

Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.

# BESM Character Manager

A comprehensive character sheet management system for the **Big Eyes, Small Mouth (BESM)** roleplaying game. Built with Ruby on Rails 8, this application provides a modern, interactive interface for tracking character attributes, defects, equipment, and campaign notes.

## Features

- **Dynamic Character Sheets**: Track stats (Body, Mind, Soul), derived values (ACV, DCV, Health, Energy), and specialized attributes.
- **Points Management**: Automatically calculate and adjust character points and bonus points (BP) from defects.
- **Asset Management**: Catalog equipment, weapons, and armor with dedicated entries.
- **Economic Tracking**: Manage character currency with a transaction history.
- **Rich Documentation**: Integrated support for game notes and descriptions using ActionText and EasyMDE.
- **Interactive UI**: Built with Tailwind CSS, Stimulus, and Turbo for a responsive, single-page feel.

## Tech Stack

- **Framework**: Ruby on Rails 8.0.2
- **Database**: SQLite 3
- **Frontend**: Tailwind CSS 4, Stimulus JS, Turbo
- **Package Manager**: Bun
- **Background Jobs**: Solid Queue
- **Caching**: Solid Cache
- **Asset Pipeline**: Propshaft

## Prerequisites

- **Ruby**: ~> 3.3.0 (check `.ruby-version`)
- **Bun**: Latest version
- **Rails**: 8.0.2

## Installation & Setup

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd besm
   ```

2. **Install dependencies**:
   ```bash
   bundle install
   bun install
   ```

3. **Database Setup**:
   ```bash
   bin/rails db:prepare
   ```

4. **Start the Development Server**:
   ```bash
   bin/dev
   ```
   *This command runs Puma, Tailwind CLI, and Bun build in parallel via `Procfile.dev`.*

## Development

### Useful Commands

- `bin/rails console` - Interactive Ruby console.
- `bin/rails db:migrate` - Run database migrations.
- `bun run build:css` - Manually rebuild Tailwind styles.
- `bundle exec rubocop` - Check code style.

### Key Directories

- `app/models/`: Character, Attribute, and Equipment logic.
- `app/controllers/`: Character sheet and transaction management.
- `app/views/`: Responsive templates for character management.
- `app/javascript/controllers/`: Stimulus controllers for dynamic UI elements.

## License

This project is private and intended for personal use or specific campaign management.

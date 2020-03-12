# Artemis <-> NCS Analytics CCA/POS integration

## Development

Duplicate the `spec/test_credentials.yml.sample` with `spec/test_credentials.yml`, and change your credentials based on the ones provided by NCS.

### Requirements
  - Ruby v2.6.5
  - Bundler v2.1.4

### Install dependencies
  - `bundle install`

### Tests
  - `bundle exec rspec`, for unit and integration tests.
  - `bundle exec rubocop`, for linting and styling.

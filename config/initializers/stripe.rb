Rails.configuration.stripe = {
  :publishable_key => 'pk_test_guYhEf593f5uMOO3eUeo363a',
  :secret_key      => 'sk_test_Z5JOgPS7MHUXUkMf9zcifndr'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
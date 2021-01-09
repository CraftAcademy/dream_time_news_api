
Stripe.plan :DreamTimePlan do |plan|
  
  plan.name = 'DreamTime Subscription'
  
  plan.amount = 110000

  plan.currency = 'sek'

  plan.interval = 'year'

  plan.interval_count = 1

  plan.trial_period_days = 0
end

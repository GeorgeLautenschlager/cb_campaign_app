module Constants
  PROTO_PATH = if Rails.env.production?
    ''
  elsif Rails.env.testing?
    'static_data/day-16/velikie-campaign.state'
  else
    'static_data/day-16/velikie-campaign.state'
  end
end
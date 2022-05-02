module Constants
  PROTO_PATH = if Rails.env.production?
    '/mnt/c/Combat_Box/apollo/my-vl-campaign'
  elsif Rails.env.testing?
    'static_data/day-16/velikie-campaign.state'
  else
    'static_data/day-16/velikie-campaign.state'
  end
end

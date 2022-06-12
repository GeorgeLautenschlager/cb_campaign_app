module Constants
  PROTO_PATH = if Rails.env.staging?
    'C:\Combat_Box\apollo\my-vl-campaign\\'
  elsif Rails.env.testing?
    'static_data/day-16/velikie-campaign.state'
  else
    # 'static_data/day-16/velikie-campaign.state'
    'static/day-16/velikie-campaign.state'
  end
end

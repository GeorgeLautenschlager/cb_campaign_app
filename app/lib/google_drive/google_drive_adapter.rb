def GoogleDriveAdapter
  def mission_card_lines
    session.spreadsheet_by_key(missions_cards_spreadsheet_key).worksheets[0]
  end

  private def session
    @session ||= GoogleDrive::Session.from_config("config.json")
  end

  private def missions_cards_spreadsheet_key
    # pull from env
  end
end
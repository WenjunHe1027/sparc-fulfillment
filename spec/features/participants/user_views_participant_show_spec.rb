require 'rails_helper'

feature 'User views Participant show', js: true do

  scenario 'and sees the Participants attributes in the header' do
    protocol = create(:protocol_imported_from_sparc)
    participant = protocol.participants.first
    visit participant_path(participant.id)

    expect(page).to have_css('#participant-info')
    expect(page).to have_content(participant.full_name)
    expect(page).to have_content(participant.mrn) unless participant.mrn.blank?
    expect(page).to have_content(participant.external_id) unless participant.external_id.blank?
    expect(page).to have_content(participant.arm.name) unless participant.arm.blank?
    expect(page).to have_content(participant.status)
    expect(page).to have_content(protocol.id)
  end
end
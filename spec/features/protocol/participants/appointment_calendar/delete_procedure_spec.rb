require 'rails_helper'

feature 'Delete Procedure', js: true do

  scenario 'User deletes a Core' do
    as_a_user_who_is_viewing_a_core_wtih_one_procedure
    when_i_delete_the_first_procedure
    i_should_not_see_the_core
  end

  scenario 'User deletes a Procedure' do
    as_a_user_who_is_viewing_a_core_wtih_two_procedures
    when_i_delete_the_first_procedure
    i_should_not_see_the_first_procedure
  end

  def as_a_user_who_is_viewing_a_core_wtih_two_procedures
    protocol      = create(:protocol_imported_from_sparc)
    participant   = protocol.participants.first
    visit_group   = participant.appointments.first.visit_group
    service       = Service.first

    visit protocol_participant_path(protocol, participant)

    bootstrap_select('#appointment_select', visit_group.name)
    find("#service_list > option[value='#{service.id}']").select_option
    fill_in 'service_quantity', with: '2'
    find('button.add_service').trigger('click')
  end

  def as_a_user_who_is_viewing_a_core_wtih_one_procedure
    protocol      = create(:protocol_imported_from_sparc)
    participant   = protocol.participants.first
    visit_group   = participant.appointments.first.visit_group
    service       = Service.first

    visit protocol_participant_path(protocol, participant)

    bootstrap_select('#appointment_select', visit_group.name)
    find("#service_list > option[value='#{service.id}']").select_option
    fill_in 'service_quantity', with: '1'
    find('button.add_service').trigger('click')
  end

  def when_i_delete_the_first_procedure
    sleep 1
    procedure = Procedure.first

    accept_confirm do
      first('button.procedure.delete').click
    end
  end

  def i_should_not_see_the_first_procedure
    expect(page).to have_css('.row.procedure', count: 1)
  end

  def i_should_not_see_the_core
    expect(page).to have_css('.row.core', count: 0)
  end
end
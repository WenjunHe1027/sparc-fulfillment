require 'rails_helper'

feature 'User views the participant tracker page', js: true do

  context 'and then tries to create a particpant note' do
    scenario 'and sees the white button with blue glyphicon denoting no notes present' do
      given_i_am_viewing_the_participant_tracker
      then_i_should_see_the_no_notes_button
    end

    scenario 'and sees the notes modal' do
      given_i_am_viewing_the_participant_tracker
      when_i_click_on_the_notes_button
      then_i_should_see_the_notes_modal
    end

    context 'and creates a note' do
      scenario 'and sees the blue button with white glyphicon denoting notes present' do
        given_i_am_viewing_the_participant_tracker
        when_i_click_on_the_notes_button
        when_i_add_a_comment_and_save
        then_i_should_see_the_notes_button
      end

      scenario 'and sees the note in the index' do
        given_i_am_viewing_the_participant_tracker
        when_i_click_on_the_notes_button
        when_i_add_a_comment_and_save
        when_i_click_on_the_notes_button
        then_i_should_see_the_note_in_the_index
      end
    end
  end

  context 'and changes the participant arm which should create a note' do
    scenario 'and sees the blue button with white glyphicon denoting notes present' do
      given_i_am_viewing_the_participant_tracker
      when_i_change_the_particpants_arm
      then_i_should_see_the_notes_button
    end
      
    scenario 'and sees the note' do
      given_i_am_viewing_the_participant_tracker
      when_i_change_the_particpants_arm
      when_i_click_on_the_notes_button
      then_i_should_see_the_arm_change_note_in_the_index
    end
  end

  def given_i_am_viewing_the_participant_tracker
    @protocol = create_and_assign_protocol_to_me
    @participant = create(:participant, protocol: @protocol, arm: @protocol.arms.first)
    @original_arm = @participant.arm

    visit protocol_path @protocol
    wait_for_ajax
    
    click_link 'Participant Tracker'
  end

  def when_i_click_on_the_notes_button
    find(".participant_notes[data-notable-id='#{@participant.id}']").click
    wait_for_ajax
  end

  def when_i_add_a_comment_and_save
    find('.new').click
    wait_for_ajax
    fill_in 'Comment', with: "Action Jackson"
    click_button 'Save'
    wait_for_ajax
  end

  def when_i_change_the_particpants_arm
    find(".change-arm[participant_id='#{@participant.id}']").click
    wait_for_ajax

    bootstrap_select "#participant_arm_id", @protocol.arms.second.name
    
    click_button 'Save'
    wait_for_ajax
  end

  def then_i_should_see_the_no_notes_button
    expect(page).to have_selector("td.notes button.btn-default")
  end

  def then_i_should_see_the_notes_button
    expect(page).to have_selector("td.notes button.btn-primary")
  end

  def then_i_should_see_the_notes_modal
    expect(page).to have_content('Participant Notes')
  end

  def then_i_should_see_the_note_in_the_index
    expect(page).to have_content('Action Jackson')
  end

  def then_i_should_see_the_arm_change_note_in_the_index
    first_arm_name = @original_arm.name
    second_arm_name = @protocol.arms.second.name

    expect(page).to have_content("Arm changed from #{first_arm_name} to #{second_arm_name}")
  end
end
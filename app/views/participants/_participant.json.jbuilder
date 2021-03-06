json.(participant)
json.id participant.id
json.protocol_id participant.protocol_id
json.srid participant.srid
json.arm_id participant.arm_id
json.arm_name truncated_formatter(participant.arm.name) if participant.arm
json.first_middle truncated_formatter(participant.first_middle)
json.first_name truncated_formatter(participant.first_name)
json.middle_initial participant.middle_initial
json.last_name truncated_formatter(participant.last_name)
json.name truncated_formatter(participant.full_name)
json.mrn truncated_formatter(participant.mrn)
json.external_id truncated_formatter(participant.external_id)
json.statusText participant.status
json.statusDropdown statusFormatter(participant)
json.notes notes_formatter(participant)
json.date_of_birth format_date(participant.date_of_birth)
json.gender participant.gender
json.ethnicity participant.ethnicity
json.race participant.race
json.address truncated_formatter(participant.address)
json.phone phoneNumberFormatter(participant)
json.details detailsFormatter(participant)
json.edit editFormatter(participant)
json.delete deleteFormatter(participant)
json.calendar calendarFormatter(participant)
json.participant_report participant_report_formatter(participant)
json.chg_arm changeArmFormatter(participant)
json.recruitment_source truncated_formatter(participant.recruitment_source)
json.coordinators formatted_coordinators(participant.protocol.coordinators.map(&:full_name))

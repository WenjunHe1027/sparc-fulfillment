$ ->

  $('#completed-appointments-table').on 'click-row.bs.table', (row, $element) ->
    $.ajax
      type: 'GET'
      url: "/appointments/#{$element.id}.js"

  $(document).on 'click', '.new-participant', ->
    data =
      'protocol_id' : $(this).data('protocol-id')

    $.ajax
      type: 'GET'
      url: "/participants/new.js"
      data: data

  $(document).on 'click', '.remove-participant', ->
    participant_id = $(this).attr('participant_id')
    name = $(this).attr('participant_name')
    del = confirm "Are you sure you want to delete #{name} from the Participant List?"
    if del
      $.ajax
        type: 'DELETE'
        url: "/participants/#{participant_id}"

  $(document).on 'click', '.edit-participant', ->
    participant_id = $(this).attr('participant_id')
    $.ajax
      type: 'GET'
      url: "/participants/#{participant_id}/edit"

  $(document).on 'click', '.participant-details', ->
    participant_id = $(this).attr('participant_id')
    $.ajax
      type: 'GET'
      url: "/participants/#{participant_id}/details"

(exports ? this).refreshParticipantTables = ->
  $("#participants-list-table").bootstrapTable 'refresh', {silent: true}
  $("#participants-tracker-table").bootstrapTable 'refresh', {silent: true}
  $("#participant-info").bootstrapTable 'refresh', {silent: true}

(exports ? this).visitSorter = (a, b) ->
  format = (string) -> 
    mdy_array = string.split('/')
    parseInt [mdy_array[2], mdy_array[0], mdy_array[1]].join('')

  if format(a) > format(b) then -1 else 1

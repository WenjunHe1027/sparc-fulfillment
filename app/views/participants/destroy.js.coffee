$("#flashes_container").html("<%= escape_javascript(render(:partial =>'shared/flash_messages')) %>");
refreshParticipantTables("<%= escape_javascript(@protocol.id.to_s) %>")

$("#modal_area").html("<%= escape_javascript(render(:partial =>'participants/change_arm_form', locals: {participant: @participant})) %>");
$("#modal_place").modal 'show'
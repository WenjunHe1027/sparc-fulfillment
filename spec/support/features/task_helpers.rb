module Features

  module TaskHelpers

    def create_tasks(count=1)
      protocol1 = create(:protocol)
      count.times do
        create(:task, protocol_id: protocol1.id)
      end
    end

    def user_fills_in_new_task_form
      task = build(:task)
      user = Identity.first

      select 'Study-level Task', from: "Task Type"
      fill_in 'Patient Name', with: task.participant_name
      fill_in 'Protocol', with: task.protocol_id
      fill_in 'Visit', with: task.visit_name
      fill_in 'Arm', with: task.arm_name
      fill_in 'Task/Service', with: task.task
      select user.full_name, from: 'Assignment'
      page.execute_script %Q{ $('#task_due_date').trigger("focus") }
      page.execute_script %Q{ $("td.day:contains('15')").trigger("click") }
    end
  end
end

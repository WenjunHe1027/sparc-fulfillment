FactoryGirl.define do

  factory :task do
    user
    assignee factory: :user
    assignee_id { rand(10) }
    participant_name { Faker::Name.name }
    task_type { "Participant-level Task" }
    protocol_id { rand(10) }
    visit_name { "Visit" + " #{rand(50)}" }
    arm_name { "Arm" + " #{rand(10)}" }
    task { Faker::Lorem.word }
    due_date Time.current
  end
end

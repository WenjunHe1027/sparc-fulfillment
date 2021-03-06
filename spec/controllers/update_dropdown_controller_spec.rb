require 'rails_helper'

RSpec.describe UpdateDropdownsController, type: :controller do

  login_user

  describe 'GET #update_dropdown' do
      
    it 'should return an array of protocols' do
      institution_organization = create(:organization_institution)
      provider_organization = create(:provider_with_child_organizations, parent_id: institution_organization.id)
      program_organization = create(:program_with_child_organizations, parent_id: provider_organization.id)
      core_organization = create(:organization_with_child_organizations, parent_id: program_organization.id)

      program_sub_service_request = create(:sub_service_request, organization: program_organization)
      program_protocol            = create(:protocol, sub_service_request: program_sub_service_request)

      provider_sub_service_request = create(:sub_service_request, organization: provider_organization)
      provider_protocol            = create(:protocol, sub_service_request: provider_sub_service_request)

      core_sub_service_request = create(:sub_service_request, organization: core_organization)
      core_protocol            = create(:protocol, sub_service_request: core_sub_service_request)

      organization_ids = [provider_organization.id, program_organization.id, core_organization.id]

      
      xhr :post, :create, org_ids: organization_ids

      expect(assigns(:protocols)).to eq([provider_protocol, program_protocol, core_protocol])
    end
  end
end
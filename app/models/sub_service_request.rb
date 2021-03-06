class SubServiceRequest < ActiveRecord::Base

  include SparcShard

  has_one :protocol
  has_one :subsidy, :dependent => :destroy

  belongs_to :owner, class_name: 'Identity'
  belongs_to :organization
  belongs_to :service_request

  delegate :service_requester, to: :service_request
end



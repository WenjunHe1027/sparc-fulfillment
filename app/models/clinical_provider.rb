class ClinicalProvider < ActiveRecord::Base

  include SparcShard

  belongs_to :organization
  belongs_to :identity
end

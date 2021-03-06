class ArmImporter

  def initialize(local_protocol, remote_protocol, remote_sub_service_request)
    @local_protocol             = local_protocol
    @remote_protocol            = remote_protocol
    @remote_sub_service_request = remote_sub_service_request
  end

  def create
    remote_protocol_arms_sparc_ids = @remote_protocol['protocol']['arms'].map { |arm| arm.values_at('sparc_id') }.compact.flatten

    if remote_protocol_arms_sparc_ids.any?

      remote_arms(remote_protocol_arms_sparc_ids)['arms'].each do |remote_arm|
        normalized_attributes         = RemoteObjectNormalizer.new('Arm', remote_arm).normalize!
        local_arm                     = Arm.create(sparc_id: remote_arm['sparc_id'])
        attributes                    = normalized_attributes.merge!({ protocol: @local_protocol })

        local_arm.update_attributes attributes

        LineItemImporter.new(local_arm, local_arm.protocol, @remote_sub_service_request['sub_service_request']).create
        VisitGroupImporter.new(local_arm, remote_arm, @remote_sub_service_request['sub_service_request']).create
      end
    end
  end

  private

  def remote_arms(arm_ids)
    @remote_arms ||= RemoteObjectFetcher.new('arm', arm_ids, { depth: 'full_with_shallow_reflections' }).build_and_fetch
  end
end

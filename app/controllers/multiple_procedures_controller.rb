class MultipleProceduresController < ApplicationController

  before_action :find_procedures, only: [:incomplete_all, :update_procedures]

  def incomplete_all
    @note = Note.new(kind: 'reason')
  end

  def update_procedures
    @core_id = @procedures.first.sparc_core_id
    status = params[:status]

    if status == 'incomplete'
      #Create test note for validation.
      @note = Note.new(kind: 'reason', reason: params[:reason], notable_type: "Procedure")

      if @note.valid?
        #Now update all @procedures with incomplete status and create notes.
        @procedures.each do |procedure|
          procedure.update_attributes(status: "incomplete", performer_id: current_identity.id)
          procedure.notes.create(identity_id: current_identity.id, kind: 'reason', reason: params[:reason], comment: params[:comment])
        end
      end
    elsif status == 'complete'
      #Mark all @procedures as complete.
      @procedures.each{|procedure| procedure.update_attributes(status: "complete", performer_id: current_identity.id)}
      @completed_date = @procedures.first.completed_date
    end
  end

  private

  def find_procedures
    @procedures = Procedure.where(id: params[:procedure_ids])
  end
end

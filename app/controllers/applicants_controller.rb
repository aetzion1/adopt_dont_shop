class ApplicantsController < ApplicationController

    def create
        @applicant = Applicant.new(applicant_params)
        if @applicant.save
            @applicant.applications.create!
            @application = Application.last
            redirect_to "/applications/#{@application.id}"
        else
            flash.now[:error] = @applicant.errors.full_messages
            render "applications/new"
        end
    end

    private
    def applicant_params
        params.permit(:name, :address, :city, :state, :zip)
    end
end
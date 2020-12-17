class AdoptionsController < ApplicationController

    def create
        adoption = Adoption.new(application_id: params[:app_id], pet_id: params[:pet_id])
        adoption.save
        redirect_to "/applications/#{params[:app_id]}"
    end

    def update
        @adoption = Adoption.find(params[:id])
        @adoption.update(adoption_params)
        redirect_to "/admin/applications/#{@adoption.application_id}"
    end

    private
    def adoption_params
        params.permit(:status)
    end

end
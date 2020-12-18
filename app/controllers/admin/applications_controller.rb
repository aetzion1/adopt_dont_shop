class Admin::ApplicationsController < ApplicationController

    def show
        @application = Application.find(params[:id])
        app_status
    end

    def app_status
        if @application.all_approved == true
            @application.pets.update_all({adoptable: false})
            @application.update!({status: "Accepted"})
        elsif @application.not_all_approved == true
            @application.update!({status: "Rejected"})
        end
    end


end
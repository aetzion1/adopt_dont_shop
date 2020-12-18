class Admin::SheltersController < ApplicationController

    def index
        @shelters = Shelter.sort_by_name_desc
    end

    def show
        @shelter = Shelter.find_by(params[:id])
        # @shelter = Shelter.find(params[:id])
    end

end
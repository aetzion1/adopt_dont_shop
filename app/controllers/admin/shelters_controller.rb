class Admin::SheltersController < ApplicationController

    def index
        @shelters = Shelter.sort_by_name_desc
    end

end
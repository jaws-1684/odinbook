class SearchController < ApplicationController
  before_action :ensure_frame_response, only: [:index]

 
  def index
    query = params[:query]
    @results = User.search(query)
  end

   private

    def ensure_frame_response
      return unless Rails.env.development?
      redirect_to root_path unless turbo_frame_request?
    end

end

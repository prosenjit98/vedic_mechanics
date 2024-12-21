class SiteRatingsController < ApplicationController
  def create
    @site_rating = SiteRating.new(rate: params[:rate].to_i, external_user_id: params[:external_user_id])
    if @site_rating.save
      render json: { message: "Thank you for your feedback!" }, status: :created
    else
      render json: { errors: @site_rating.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
class ImageController < ApplicationController
  def show
    @model = params[:model].singularize.classify.constantize.find(params[:id])

    unless @model.image_auth(params[:image].to_sym)
       return head :forbidden
    end

    variant_style = @model.derivation_style(params[:variant].to_sym)

    if params[:visibility] == "public"
      redirect_to @model.public_send(params[:image]).derivation_url(*variant_style)
    else
      # expires_in 15.minutes, :public => true
      redirect_to @model.public_send(params[:image]).derivation_url(*variant_style, expires_in: 900)
    end
  end
end

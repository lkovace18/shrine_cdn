class DerivationsController < ApplicationController
  def image

    # ! not needed
    # # auth
    # if [true, false].sample == true
    #   return head :forbidden
    # end

    #debugger
    set_rack_response ImageUploader.derivation_response(request.env)
  end

  private

    def set_rack_response((status, headers, body))
      self.status = status
      self.headers.merge!(headers)
      self.response_body = body
    end
end

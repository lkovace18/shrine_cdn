# frozen_string_literal: true

class Gallery < ApplicationRecord
    include ImageUploader::Attachment(:image) # adds an `image` virtual attribute

    DERIVATION_STYLES = {
        thumbnail: [:thumbnail, 200, 200]
    }

    def derivation_style(style)
        DERIVATION_STYLES[style]
    end

    # example of image auth
    def image_auth(image)
        [true, false].sample == true
    end
end

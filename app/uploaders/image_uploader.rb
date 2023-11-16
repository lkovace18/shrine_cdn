# frozen_string_literal: true

class ImageUploader < Shrine
    # plugins and uploading logic

    signer = CdnSignerService.new("123")

    plugin :signature
    plugin :derivation_endpoint,
            # cache_control: { public: true, max_age: 24*60*60 },
            secret_key: "123",
            prefix: "derivations/image",
            host: ENV.fetch("SHRINE_DERIVATION_HOST", nil),
            signer: ->(url, expires_in:, version:) do
                signer.signed_url(url, expires_in:, version:)
            end,
            upload: true
            #upload_redirect: true


    derivation :thumbnail do |file, width, height|
        ImageProcessing::MiniMagick
          .source(file)
          .resize_to_limit!(width.to_i, height.to_i)
      end
end
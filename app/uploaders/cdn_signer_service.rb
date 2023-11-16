# frozen_string_literal: true

require "shrine"

class CdnSignerService
  def initialize(secret_key)
    @secret_key = secret_key
  end

  def signed_url(url, **)
    original_url = url.gsub("/derivations/image/", "")

    params = Rack::Utils.parse_query(query(**).to_s)
    params.merge!("signature" => generate_signature("#{original_url}?#{query(**)}")) # rubocop:disable Performance/RedundantMerge
    final_query = Rack::Utils.build_query(params)

    "#{url}?#{final_query}"
  end

  def generate_signature(string)
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("SHA256"), @secret_key, string)
  end

  def query(expires_in: 15.minutes, type: nil, filename: nil, disposition: nil, version: nil)
    # Do not create expiry link on every request
    last_quarter = Time.zone.at((Time.current.to_i / 900).floor * 900)
    expire_at_time = last_quarter + expires_in if expires_in

    params = {}
    params[:expires_at]  = expire_at_time.to_i if expires_in
    params[:version]     = version if version
    params[:type]        = type if type
    params[:filename]    = filename if filename
    params[:disposition] = disposition if disposition

    Rack::Utils.build_query(params)
  end
end

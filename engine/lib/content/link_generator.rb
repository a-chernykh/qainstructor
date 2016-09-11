module Content

  class LinkGenerator
    def self.instance
      new(key_pair_id: ENV['CLOUDFRONT_KEYPAIR_ID'],
          cloudfront_domain: ENV['CLOUDFRONT_DOMAIN'])
    end

    def initialize(key_pair_id:, cloudfront_domain:)
      @key_pair_id = key_pair_id
      @private_key_path = "config/pk-#{@key_pair_id}.pem"
      @cloudfront_domain = cloudfront_domain
    end

    def asset_url(path:)
      signer = Aws::CloudFront::UrlSigner.new(
        key_pair_id: @key_pair_id,
        private_key_path: @private_key_path
      )

      url = "https://#{@cloudfront_domain}/#{path}"

      expiration_time = Time.now.to_i + 21600

      policy = <<-EOT
{
  "Statement": [{
    "Resource":"#{url}",
    "Condition":{
      "DateLessThan":{"AWS:EpochTime":#{expiration_time}}
    }
  }]
}
EOT

      url = signer.signed_url(url, policy: policy)
      url
    end
  end

end

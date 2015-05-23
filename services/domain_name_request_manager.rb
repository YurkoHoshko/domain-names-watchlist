class DomainNameRequestManager
  attr_reader :domain_name
  
  def initialize(domain_name)
    @domain_name = domain_name
  end

  def process_request
    record = cached_domain_name_record || create_domain_name_record
    record.values.to_json
  end

  private

  def cached_domain_name_record
    DomainNameRecord.where(:domain_name => domain_name).first
  end

  def create_domain_name_record
    third_party_response = client.lookup(domain_name)
    domain_name_record_builder(third_party_response).build
  end
  
  def client
    Whois::Client.new
  end

  def domain_name_record_builder(third_party_response)
    DomainNameRecordBuilder.new(third_party_response)
  end
  
end
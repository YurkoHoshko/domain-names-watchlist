class DomainNameRecordBuilder
  extend Forwardable
  delegate [:domain, :status, :created_on, :expires_on, :contacts] => :plain_record

  attr_reader :plain_record


  def initialize(record)
    @plain_record = record
  end

  def build
    params = {
      :domain_name => domain,
      :status => status,
      :created_on => created_on.strftime("%FT%R" ),
      :expires_on => expires_on.strftime("%FT%R"),
      :contact_name => contact.try(:name),
      :contact_email => contact.try(:email)
    }

    DomainNameRecord.create(params)
  end

  private
  def contact
    contacts.first
  end
  
end
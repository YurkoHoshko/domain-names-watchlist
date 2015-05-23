class WatchlistManager
  attr_reader :watchlist_id
  
  def initialize(watchlist_id)
    @watchlist_id = watchlist_id
  end

  def add_to_watchlist(domain_name_record_id)
    if DomainNameRecord[domain_name_record_id]
      WatchlistItem.find_or_create(
        :watchlist_id => watchlist_id,
        :domain_name_record_id => domain_name_record_id
      )
      true
    else raise Sinatra::NotFound
    end
  end

  def retrieve_watchlist
    watched_domains = DomainNameRecord.join(
      WatchlistItem.where(:watchlist_id => watchlist_id), 
      :domain_name_record_id => :id
    ).map(&:values)
    
    {:watchlist => watched_domains}.to_json      
  end

end
require_relative "environment"

class DomainNamesWatchlist < Sinatra::Base
  enable :sessions
  
  set :assets_prefix, %w(assets)
  set :assets_precompile, %w(application.js)
  register Sinatra::AssetPipeline

  get "/domain_name_info" do
    DomainNameRequestManager.new(params[:domain_name]).process_request
  end

  post "/watchlist" do
    WatchlistManager.new(current_user_watchlist_id).add_to_watchlist(params[:domain_name_record_id])
  end

  get "/watchlist" do
    WatchlistManager.new(current_user_watchlist_id).retrieve_watchlist
  end

  get "/" do
    erb :index
  end

  private
  def current_user_watchlist_id
    if session[:watchlist_id]
      session[:watchlist_id]
    else
      session[:watchlist_id] = Digest::SHA256.hexdigest Time.now.to_s  
    end
  end
end
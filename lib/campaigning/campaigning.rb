gem "soap4r", "~> 1.5.0"
require File.expand_path(File.dirname(__FILE__)) + '/client.rb'
require File.expand_path(File.dirname(__FILE__)) + '/campaign.rb'
require File.expand_path(File.dirname(__FILE__)) + '/subscriber.rb'
require File.expand_path(File.dirname(__FILE__)) + '/list.rb'
require File.expand_path(File.dirname(__FILE__)) + '/module_mixin.rb'

module Campaigning
  include ModuleMixin

  ##
  #Gets the server system time for your time zone.
  #This is handy for when you are syncing your {Campaign Monitor}[http://www.campaignmonitor.com] lists with some other in-house list,
  #allowing you accurately determine the time on our server when you carry out the synchronization.
  def self.system_date
    response = @@soap.getSystemDate(:apiKey => CAMPAIGN_MONITOR_API_KEY)    
    dateTime = handle_response response.user_GetSystemDateResult
  end

  ##
  #This method returns an Array of Strings representing all the available timezones.
  def self.timezones    
    handle_response @@soap.getTimezones(:apiKey => CAMPAIGN_MONITOR_API_KEY).user_GetTimezonesResult
  end

  ##
  #This method returns an Array of Strings representing all the available countries.
  def self.countries
    response = @@soap.getCountries(:apiKey => CAMPAIGN_MONITOR_API_KEY)
    dateTime = handle_response response.user_GetCountriesResult
  end

  ##
  #This method turns the API debug mode to :on and :off, which will display at the console all SOAP requests made to the API server.
  # 
  def self.set_debug_mode(option)
    option = STDERR if option == :on
    @@soap.wiredump_dev = option
  end

  def self.set_endpoint_url(endpoint_url)
    @@soap = Campaigning::ApiSoap.new(endpoint_url)
  end
end

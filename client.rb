require 'double_bag_ftps'
require 'dnssd'

browser = DNSSD::Service.new
services = {}

browser.browse '_ftps._tcp' do |reply|
  puts reply.fullname
  DNSSD::Service.new.resolve(reply) do |r|
    puts "Listing files available on #{r.name} on #{r.target}:#{r.port}"
    ftp = DoubleBagFTPS.new
    ftp.ssl_context = DoubleBagFTPS.create_ssl_context(
                          :verify_mode => OpenSSL::SSL::VERIFY_NONE)
    ftp.passive = true
    ftp.connect r.target, r.port #this is where it's getting CONNREFUSED, not sure why
    ftp.login
    puts ftp.list
  end
end


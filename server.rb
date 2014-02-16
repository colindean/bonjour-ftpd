require 'ftpd'
require 'tmpdir'
require 'dnssd'
require 'logger'

module Ftpd
  class Server
    def raw_socket
      @server_socket.to_io
    end
  end
end

class Driver
  include Ftpd::InsecureCertificate

  def initialize(temp_dir)
    @temp_dir = temp_dir
  end

  def authenticate(user, password)
    true
  end

  def file_system(user)
    Ftpd::DiskFileSystem.new(@temp_dir)
  end

end

Dir.mktmpdir do |temp_dir|
  driver = Driver.new(temp_dir)
  server = Ftpd::FtpServer.new(driver)
  server.interface = "0.0.0.0"
  server.port = 8721
  server.certfile_path = "cert2.pem"
  server.tls = :explicit
  server.log = Logger.new STDOUT
  server.start
  DNSSD.announce server.raw_socket, 'Ruby FTPS DNSSD Example', 'ftps'
  puts "Server listening on port #{server.bound_port}"
  puts "Files can go in #{temp_dir}"
  gets
end

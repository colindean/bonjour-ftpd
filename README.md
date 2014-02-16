bonjour-ftpd
============

A simple SSL FTP server/client that uses DNS-SD for discovery

by @colindean

Introduction
------------

I wrote this as a simple example meeting the requirements of a 
[post on /r/ruby](https://pay.reddit.com/r/ruby/comments/1y13h4/secure_peertopeer_in_ruby/cfgi4iq): 
A peer-to-peer file transfer system featuring peer discovery and secure file transfer.

This example sets up an FTPd with SSL enabled that announces its availability using DNS-SD and mDNS.
The client then browses for servers that are announcing its expected service name, then connects and lists files.

Requirements
------------

See Gemfile. I wrote this on Ruby 2.1.0 on OSX.

Running
-------

First, install gems.

    bundle install
    
In one terminal, run the server.

    ruby server.rb
    
Grab the directory that's output when the server starts. You can put a file in there with something like

    touch /var/whatever/this/is/this-is-a-file
    
In another terminal, 
    
    ruby client.rb
    
You should see some output like this:

    Ruby\032FTPS\032DNSSD\032Example._ftps._tcp.local.
    Listing files available on Ruby FTPS DNSSD Example on kid.local.:8721
    -rw-r--r-- 1 colin    staff           0 Feb 16 14:03 this-is-a-file

The server will stay running. The client will, too, so you'll have to kill it to
run it again.

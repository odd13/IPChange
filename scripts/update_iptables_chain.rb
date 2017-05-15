#!/usr/bin/ruby

require 'sqlite3'

system("sudo iptables -F")

def cmd(cmd_options)
  #system("echo " + cmd_options)
  #system("sudo iptables -F")
  system(cmd_options)
end


begin
    db = SQLite3::Database.open "/home/oddie/projects/ipchange/db/development.sqlite3"

    stm = db.prepare "SELECT email, last_sign_in_ip FROM users" 
    rs = stm.execute 
    
    rs.each do |row|
      if row[1].nil?
        exit
      else
        puts cmd("sudo iptables -A INPUT -p tcp --dport 80 -s #{row[1].to_s} -j ACCEPT")
      end
      # puts row.join "\s"
    end

    
rescue SQLite3::Exception => e     
  puts "Exception occurred"
  puts e
    
end

#puts 'hello world!!'

#cmd("echo IPTABLES} -P f} DROP")

#!/home/odd13/.rubies/ruby-2.3.1/bin/ruby

require 'sqlite3'

system("iptables -F")
system("iptables-restore < /etc/ipsave.cfg")

def cmd(cmd_options)
  #system("echo " + cmd_options)
  #system("sudo iptables -F")
  system(cmd_options)
end


begin
    db = SQLite3::Database.open "/home/odd13/projects/ipchange/db/development.sqlite3"

    stm = db.prepare "SELECT email, last_sign_in_ip FROM users" 
    rs = stm.execute 
    
    rs.each do |row|
      if row[1].nil?
        exit
      else
        puts cmd("iptables -A INPUT -s #{row[1].to_s} -p tcp -m tcp --dport 1511 -m state --state NEW -j ACCEPT")
      end
      # puts row.join "\s"
    end

    
rescue SQLite3::Exception => e     
  puts "Exception occurred"
  puts e
    
end

#puts 'hello world!!'

#cmd("echo IPTABLES} -P f} DROP")

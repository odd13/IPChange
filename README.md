# IPChange
This is a session logging application that will be placing in iptables rules for customers with dynamic IP addresses that require remote access.

# Requirements
Ruby on Rails knowledge and a current working iptables set of rules [IPTables Information](https://help.ubuntu.com/community/IptablesHowTo).

# Process Overview 
![Image of Process](https://raw.githubusercontent.com/odd13/IPChange/master/images/ipchange.png)
1. User is fronted with a login page.
2. User logs and the page display ("Thanks for logging in").
3. At the session login, the users login time is placed into a table.
6. A cron script flushes the older rules added in iptables
5. A cron script reviews the IP addresses and places them in the INPUT chain for iptables.

# Development Environment
* Ubuntu 17.04
* Ruby on Rails (chruby)
* Python

# Run the app locally
## First steps to get the App
1. [Install Ruby on Rails](https://www.ruby-lang.org/en/documentation/installation)
2. Clone the repository from <code>git clone https://github.com/odd13/IPChange</code>
3. cd into the app directory (IPChange)
4. Run <code>gem install bundler</code> to install bundler
5. Run <code>bundler install</code> to install app dependencies

## Second Configure the database
1. Make sure you are in the applications directory, if not change to the directory of the application <code>cd IPChange</code>
2. Make sure you have created the database, for the purpose of this demonstration I have kept the dastabase simple as a SQLite3 database. <code>rake db:create db:migrate</code>. To place users in the database, you will either need to add them manually or through <code>rake db:seed</code>. Edit the IPChange/db/seed.rb file and update the required users. 
3. Change to the scripts directory <code>cd IPChange/scripts</code>
4. Run the test script <code>python test_db_connection.py</code> output: <code>Test successful, I can connect to the database</code> 
6. Run <code>rails server</code>
7. Access the running app in a browser at http://localhost:3000 and login

## Third to create the cronjobs with the scripts
1. Change to the application directoy <code>cd IPChange/scripts</code>
2. You will need to edit the script <code>update_iptables.py</code> with your favourite text editor and update the iptables rules that are to be created when soemone logs in. At the moment there is a whitelist for the users logged in IP address on port 1151.
3. For this step you will need to edit crontab to have the listed script run on a time you require;
  <code>sudo crontab -e</code> and add the following: <code>*/5 * * * * /home/yourusername/IPChange/scripts/update_iptables.py</code>

<code>update_iptables.py</code> will now run every 5 minutes and complete the following: 
 * check for new user IP address added to the database. 
 * Remove old iptabvle chain entries
 * Add's those new to the iptables chain.

You can test this by logging in with the users you either created manually (through the rails console, not covered here) or through the seed file under db/seed.rb edited in the above steps. Then check the iptables input chain has updated <code>sudo iptables -L</code>.


 

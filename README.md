# IPChange
This is a session logging application that will be placing in iptables rules for customers with dynamic IP addresses that require remote access.

# Requirements
Ruby on Rails is required for this application.

# Process Overview 
1. User is fronted with a login page.
2. User logs and the page display ("Thanks for logging in").
3. At the session login, the users login time, IP and flag to show that this is a new IP for the user is placed into a table.
4. A cron script reviews the only NEW from the database and places them in the INPUT chain for iptables.
5. The older entries are removed by compairing the new to the old.

# Development Environment
* Ubuntu 17.04
* Ruby 
* Rails

# Run the app locally
## First steps to get the App
1. [Install Ruby](https://www.ruby-lang.org/en/documentation/installation)
2. Clone the repository from <code>git clone https://github.com/odd13/IPChange</code>
3. cd into the app directory (IPChange)
4. Run <code>gem install bundler</code> to install bundler
5. Run <code>bundler install</code> to install app dependencies
6. Run <code>rails server</code>
7. Access the running app in a browser at http://localhost:3000

## Second Configure the database
1. Change to the directory of the application <code>cd IPChange</code>
2. Make sure you have created the database, for the purpose of this demonstration I have kept the dastabase simple as a SQLite3 database. <code>rake db:create db:migrate</code> 
3. Change to the scripts directory <code>cd scripts</code>
4. Run the test script <code>ruby test_db_connection.rb</code> output: <code>Test successful, I can connect to the database</code> 

## Third to create the cronjobs with the scripts
1. Change to the application directoy <code>cd IPChange</code>
2. Change to the scripts directory <code>cd scripts</code>
3. For this step you will need to edit crontab to have the listed script run on a time you require;
  <code>sudo crontab -e</code> and add the following: <code>5 * * * * /home//<yourusername/>/IPChange/scripts/update_iptables.sh</code>

<code>update_iptables.sh</code> will now run every 5 minutes: 
 * check for new user IP address added to the database. 
 * Remove old iptabvle chain entries
 * Add's those new to the iptables chain.

 

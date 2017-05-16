#!/usr/bin/python
# -*- coding: utf-8 -*-

import sqlite3 as lite
import sys
from subprocess import call
import os

os.system("iptables -F")
os.system("iptables-restore < /etc/ipsave.cfg")


con = lite.connect('/home/odd13/projects/ipchange/db/development.sqlite3')

with con:    
    
    cur = con.cursor()    
    cur.execute("SELECT email, current_sign_in_ip FROM Users")

    rows = cur.fetchall()

    for row in rows:
	if row[1] is None:
		print ""
	else:
        	print row[1]
		print "iptables -A INPUT -s "+ str(row[1]) + " -p tcp -m tcp --dport 1511 -m state --state NEW -j ACCEPT"
		os.system("iptables -A INPUT -s "+ str(row[1]) + " -p tcp -m tcp --dport 1511 -m state --state NEW -j ACCEPT")

def comd(cmd_to_run):
	call(cmd_to_run)

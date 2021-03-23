#!/bin/bash

# Script Name: Bash Domain Analyzer
# Class Name: Ops 201
# Author Name: Jamie Giannini
# Date of last revision: 3/22/2021
# Description of purpose: Create a bash script that asks a user to type a domain, then displays information about the typed domain.

# Objectives:
# [X] Install whois on Ubuntu VM
# [X] Write a function that should:
# [X] Take user input string (domain)
# [X] Run whois against the input string
# [X] Run dig against the input string
# [X] Run host against the input string
# [X] Run nslookup against the input string
# [X] Output the results to a single .txt file  and open it with any text editor
# [X] Script should use at least one variable and one function 

# Stretch goals:
# [X] Check the input string is a valid domain
# [X] Research and add additional tools that fetch domain information to this shell script
# [X] Sanitize the output to only display useful information 


#grab user input
function get_input () {
    echo "Enter a domain address: "
    read -r up #user input
    if [[ $up == +(*.com|*.org|*.gov) ]] #checks entry to see if it is a valid domain
    then
    domain_analysis=( "run_who_is $up" "run_dig $up" "run_host $up" "run_ns $up" "run_ping $up")
    for i in {0..4}  
        do 
            ${domain_analysis[i]} >> "$HOME/Documents/domain_analysis.txt"
        done
    else
    echo "Invalid entry"
    fi
}

#run whois lookup
function run_who_is () {
    echo ""
    echo "============================Whois Output...====================================="
    #command whois "$1"
    whois "$1" | sed -n 1,15p #only prints lines 1-15 (the important stuff!)
}

#run dig
function run_dig () {
   echo ""
   echo "============================Dig Output...====================================="
   command dig "$1" | tr -d ';' #removes all the semicolons in front of the results
}

#run host
function run_host () {
    echo ""
    echo "============================Host Output...====================================="
    command host "$1"
}

#run nslookup
function run_ns () {
    echo ""
    echo "============================NSLookup Output...====================================="
    command nslookup "$1"
}

#run ping
function run_ping () {
    echo ""
    echo "============================Ping Result...====================================="
    command ping "$1" -c 3 #ends it after 3 replies
}

get_input #call user input function and get the party started
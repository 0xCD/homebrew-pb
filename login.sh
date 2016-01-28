#!/bin/bash
echo "Type Pastebin username"
read login
echo "Type Pastebin password"
read -s password
result=$(curl -s -X POST -d "api_dev_key=f2a3a87e44febec32ae2f401efe61888&api_user_name=${login}&api_user_password=${password}" "http://pastebin.com/api/api_login.php")
if [[ "$(echo "$result" | head -c15)"  == "Bad API request" ]]; then
	echo "Error. $result"
else 
	touch ~/.pbconf
	chmod 600 ~/.pbconf
	echo "$result" > ~/.pbconf
	echo "Login successful"
	echo "Go to http://pastebin.com/api and copy your unique developer API key (account required, it's free)"
	echo "Paste key here"
	read dev_key
	echo "$dev_key" >> ~/.pbconf
	echo "Done"
	chmod 400 ~/.pbconf
fi
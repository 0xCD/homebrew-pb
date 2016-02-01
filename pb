#!/bin/bash
#AUTHOR 0xCD https://github.com/0xCD
USAGE='USAGE: \n -g — create paste as guest\n -p — private (public by default)\n -u — unlisted\n -n name — title of paste\n -e time {10M|1H|1D|1W|2W|1M|N} - time to expire (never by default)\n -f language — highlighting paste (plain text by default); all available here http://pastebin.com/api#5'
if [[ "$1" == "-h" ]]; then
	echo -e "$USAGE"
	exit 0
else
if [ ! -f ~/.pbconf ]; then
	echo "~/.pbconf not exist. Login required."
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
		echo "Would you use own dev_key (manual adding fron your account required)?[y/n]"
		read need_key
		if [[ "$need_key" = "n" ]]; then
			dev_key='f2a3a87e44febec32ae2f401efe61888'
		else echo "Go to http://pastebin.com/api and copy your unique developer API key (account required, it's free)"
		echo "Paste key here"
		read dev_key
		fi
		echo "$dev_key" >> ~/.pbconf
		echo "Done"
		chmod 400 ~/.pbconf
	fi
else

api_paste_code="$(cat /dev/stdin)"
api_url='http://pastebin.com/api/api_post.php'
api_dev_key=$(cat ~/.pbconf | sed -n 2p) #you can get own dev key here http://pastebin.com/api
api_option='paste'
api_user_key=$(cat ~/.pbconf | sed -n 1p)
api_paste_name='Untitled'
api_paste_format='text'
api_paste_private=0
api_paste_expire_date="N"
expire_date_arr=('N', '10M', '1H', '1D', '1W', '2W', '1M')
while getopts ":n:e:f:puhg" opt; do
  case $opt in
    g)
	  api_user_key=''  
      ;;
  	h)
		echo -e "$USAGE"
		exit 0
		;;
  	f) 
	    api_paste_format=$OPTARG
	  ;;
	:)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
    p)
		if [[ api_paste_private -eq 1 ]]
	    then 
	    	echo "paste couldn't be private and unlisted in the same time"
	    	exit 1
	  else
	    api_paste_private=2
	  fi
      ;;
    u)
	  if [[ api_paste_private -eq 2 ]]
	    then 
	    	echo "paste couldn't be private and unlisted in the same time"
	    	exit 1
	  else
	    api_paste_private=1
	  fi	  
      ;;
    n) 
	    api_paste_name=$OPTARG
	  ;;
	:)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
	e) 
	    if [[ " ${expire_date_arr[*]} " == *"$OPTARG"* ]]; then
    	api_paste_expire_date="$OPTARG"
    	echo "$OPTARG"
    	else echo "wrong -e argument" 
		fi
	  ;;
	:)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;	
    \?)
      echo "Invalid option: -$OPTARG" >&2
      echo "$USAGE"
      exit 1
      ;;
  esac
done
query="api_option=paste&api_user_key=${api_user_key}&api_paste_private=${api_paste_private}&api_paste_expire_date=${api_paste_expire_date}&api_paste_name=${api_paste_name}&api_paste_format=${api_paste_format}&api_dev_key=${api_dev_key}&api_paste_code=$api_paste_code"
curl -s -X POST -d "$query" "$api_url" -w '\n'
fi
fi
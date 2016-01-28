#!/bin/bash
#AUTHOR 0xCD https://github.com/0xCD
read api_paste_code
api_url='http://pastebin.com/api/api_post.php'
api_dev_key=$(cat ~/.pbconf | sed -n 2p) #you can get own dev key here http://pastebin.com/api
api_option='paste'
api_user_key=$(cat ~/.pbconf | sed -n 1p)
api_paste_name='Untitled'
api_paste_format='text'
api_paste_private=0
api_paste_expire_date="N"
expire_date_arr=('N', '10M', '1H', '1D', '1W', '2W', '1M')
USAGE='USAGE: \n -p — private (public by default)\n -u — unlisted\n -n name — title of paste\n -e time {10M|1H|1D|1W|2W|1M|N} - time to expire (never by default)\n -f language — highlighting paste (plain text by default)'
while getopts ":n:e:f:puh" opt; do
  case $opt in
  	h)
		echo -e "$USAGE"
		exit 0
		;;
  	n) 
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
    	echo "arr contains $OPTARG"
    	api_paste_expire_date="$OPTARG"
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
query="api_option=paste&api_user_key=${api_user_key}&api_paste_private=${api_paste_private}&api_paste_name=${api_paste_name}&api_paste_format=${api_paste_format}&api_dev_key=${api_dev_key}&api_paste_code=$api_paste_code"
curl -s -X POST -d "$query" "$api_url"
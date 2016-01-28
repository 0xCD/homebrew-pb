## pb
Create paste on pastebin.com from terminal.app
### Instalation

- cd /path/to/pb
- sudo ./install.sh
- type root password
- login to pastebin.com in teminal and paste dev_key from [here](http://pastebin.com/api) (account required)

### Usage

- `echo "wow such pb" | pb`
- `cat myscript.py | pb | pbcopy` (`pbcopy` to copy link to clipboard)
- `pb -h`
USAGE: 

 -p — private (public by default)

 -u — unlisted

 -n name — title of paste

 -e time {10M|1H|1D|1W|2W|1M|N} - time to expire (never by default)
 
 -f language — highlighting paste (plain text by default)

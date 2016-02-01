## pb
CLI PAstebin.com client
### Instalation
Brew (soon):

`brew install pb`

Manual:

`cd /path/to/pb`

`install -c pb ${PREFIX:-/usr/local}/bin`

### Usage

- `echo "wow such pb" | pb`
- `cat myscript.py | pb | pbcopy` (`pbcopy` to copy link to clipboard)
- `pb -h`
USAGE: 

USAGE: 

 -g — create paste as guest
 
 -p — private (public by default)
 
 -u — unlisted
 
 -n name — title of paste
 
 -e time {10M|1H|1D|1W|2W|1M|N} - time to expire (never by default)
 
 -f language — highlighting paste (plain text by default); all available here http://pastebin.com/api#5
### License
GPLv3
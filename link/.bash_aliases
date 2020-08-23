alias nyan='telnet nyancat.dakko.us'

function asmrdl() {
	( cd /data/Videos/ASMR/ && youtube-dl "$*" )
}

alias dns-clean='sudo service dns-clean restart'

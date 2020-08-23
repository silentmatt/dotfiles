#!/bin/bash

LOGIN_URL="${1:?'Login URL is required'}"
USERNAME="${2:-admin}"
PASSWORD=${3:-password}
REDIRECT="${LOGIN_URL/wp-login.php/wp-admin/}"

(curl -sSI "$LOGIN_URL" | grep -qi '^HTTP/1\.1 30[12]') && exit 1

#echo Trying $LOGIN_URL with username $USERNAME and password $PASSWORD
curl -sS -D - "$LOGIN_URL" \
	-H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36' \
	-H 'Content-Type: application/x-www-form-urlencoded' \
	-H "Referer: $LOGIN_URL" \
	--data-urlencode "log=$USERNAME" \
	--data-urlencode "pwd=$PASSWORD" \
	--data-urlencode "wp-submit=Log In" \
	--data-urlencode "redirect_to=$REDIRECT" \
	--data-urlencode "testcookie=1" \
	-o /dev/null |
	grep -qi '^HTTP/1\.1 302'

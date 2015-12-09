#!/bin/bash
# Optional: Pushover Notifications
# www.pushover.net provides a mechnism to receive messages to your smart device. This is used when an error occurs in the script. Enter your pushover token/key to utilize this service.

push_token=""
push_key=""

function pushover {
	curl -s -F "token=$push_token" -F "user=$push_key" -F "message=$1" https://api.pushover.net/1/messages.json > /dev/null
}
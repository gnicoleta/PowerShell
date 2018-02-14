#!/bin/bash

sourceSubscriptionId="$1"
destinationSubscriptionId="$2"
containerDestination="$3"
containerSource1="$4"
connectionStringDestination="$5"

old_subscription() {
    az account set --subscription $sourceSubscriptionId
    mkdir ~/download
    ./parse_images.sh ~/downloaded $1
}

new_subscription() {
    #or az login and login with the other account, in case the subscription does not work
    az account set --subscription $destinationSubscriptionId
    az storage blob upload-batch --destination $containerDestination --source ~/download/ --connection-string $connectionStringDestination
}

old_subscription $containerSource1
new_subscription

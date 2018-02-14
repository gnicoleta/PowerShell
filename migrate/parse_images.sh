#!/bin/sh
filename="$1"
container="$2"
connectionStringSource="$3"
while read -r line
do
    name="$line"
    echo "NAME: $name"
    az storage blob download --container-name $container --name $name --file ~/$name --connection-string $connectionStringSource --if-modified-since 2017-09-01
    if test $? -eq 0
         then echo "$name" >> ~/upload
         mv ~/$name ~/download/
    else
         echo "$name is too old"
         #rm $name so that it would delete the images which are not good
    fi
done < "$filename"


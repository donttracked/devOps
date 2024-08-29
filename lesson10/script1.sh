#!/bin/bash

mkdir -p ~/myfolder

echo -e "Привет!\n$(date)" > ~/myfolder/file1.txt

touch ~/myfolder/file2.txt
chmod 777 ~/myfolder/file2.txt

< /dev/urandom tr -dc 'A-Za-z0-9' | head -c 20 > ~/myfolder/file3.txt
echo "" >> ~/myfolder/file3.txt

touch ~/myfolder/file4.txt
touch ~/myfolder/file5.txt

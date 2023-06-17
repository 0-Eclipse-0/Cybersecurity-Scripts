#!/bin/bash

# Sorry if this is an ugly script. It does the job it is supposed to do and was made only to fix a problem I was having with
# another project.

get_string () {
  ip route show default | grep -oP '(default\svia\s).*' > gateway_string.txt
}

format_string () {
  sed 's/default\svia\s//g' gateway_string.txt > gateway_string2.txt
  sed 's/\sdev\swlan0//g' gateway_string2.txt > gateway_string3.txt
  sed 's/\s//' gateway_string3.txt > gateway.txt
}

remove_files () {
  rm gateway_string.txt
  rm gateway_string2.txt
  rm gateway_string3.txt
}

get_string
format_string
remove_files

cat gateway.txt

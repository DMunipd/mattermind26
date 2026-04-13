#!/bin/bash

certificates_dir="foocertificates"
csv_file="hydrorom-data.csv"

[[ ! -d "$certificates_dir" ]] && { echo "Directory \"$certificates_dir\" not found"; exit 1; } 1>&2

{
   while read -r fullname; do
      lastname=$(echo "$fullname" | cut -d' ' -f 2-)
      lastname=${lastname,,}
      lastname=${lastname// /_}
      echo "curr line: $fullname"
      # echo "last name: $lastname"
      sed -e "s/NAME-TO-REPLACE/${fullname}/g" \
         -e "s#logos#../logos#g" \
         -e "s#firma_larese#../firma_larese#g" \
         main.tex > "certificates/certificate_${lastname}.tex"
   done
} < "$csv_file"

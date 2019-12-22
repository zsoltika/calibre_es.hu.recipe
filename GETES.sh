#!/bin/bash

# Get the annual weekly id of the newspaper

AKT_LAPSZAM=$(curl -s https://www.es.hu | fgrep '"lapszamvalaszto"')
year=$(echo $AKT_LAPSZAM | sed 's/.*id="lapszamvalaszto">[ \t]*\([^ ]\+\)\..*/\1/')
week=$(echo $AKT_LAPSZAM | sed 's/.*.vfolyam,[ \t]\+\([0-9]\+\)\(-[0-9]\+\)*\.[ \t]sz.m.*/\1\2/')

## DEBUG
### echo $year 
### echo $week
### exit 0

ebook-convert es.recipe es_${year}-${week}.mobi \
              --output-profile kindle \
              --smarten-punctuation \
              --change-justification justify \
              --title "Élet és Irodalom ${year}. ${week}. szám" \
              --toc-title "Tartalom" \
              --remove-paragraph-spacing-indent-size 1.3 \
              --remove-paragraph-spacing \
              --sr1-search ".A vers olvas.s.hoz, k.rj.k, fizessen el..." \
              --sr1-replace ""
ebook-convert es_${year}-${week}.mobi es_${year}-${week}.pdf \
              --extra-css "body  {background-color: white; color: black; }" \
              --paper-size a4 \
              --smarten-punctuation \
              --change-justification justify \
              --title "Élet és Irodalom ${year}. ${week}. szám" \
              --toc-title "Tartalom" \
              --pretty-print \
              --insert-blank-line \
              --remove-paragraph-spacing-indent-size 1.3 \
              --remove-paragraph-spacing \
              --margin-bottom 50.0 \
              --margin-top 50.0 \
              --margin-left 50.0 \
              --margin-right 50.0 && \
echo "COPYING SOME FILEZ" && \
cp es_${year}-${week}.* /mnt/c/Users/ebotzso/Documents && \
echo "AND done...."



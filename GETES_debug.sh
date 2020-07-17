#!/bin/bash

# Get the annual weekly id of the newspaper

AKT_LAPSZAM=$(curl -s https://www.es.hu | fgrep '"lapszamvalaszto"')
year=$(echo $AKT_LAPSZAM | sed 's/.*id="lapszamvalaszto">[ \t]*\([^ ]\+\)\..*/\1/')
week=$(echo $AKT_LAPSZAM | sed 's/.*.vfolyam,[ \t]\+\([0-9]\+\)\(-[0-9]\+\)*\.[ \t]sz.m.*/\1\2/')

## DEBUG
### echo $year 
### echo $week
### exit 0

echo "" > debug.log

ebook-convert esdebug.recipe es_${year}-${week}.mobi \
              --test 11 5 \
              -vv \
              -d debugdir \
              --output-profile kindle \
              --smarten-punctuation \
              --change-justification justify \
              --title "Élet és Irodalom ${year}. ${week}. szám" \
              --toc-title "Tartalom" \
              --remove-paragraph-spacing-indent-size 1.3 \
              --remove-paragraph-spacing \
              --sr1-search ".A vers olvas.s.hoz, k.rj.k, fizessen el..." \
              --sr1-replace "" &> debug.log

#!/bin/bash

# Get the annual weekly id of the newspaper

AKT_LAPSZAM=$(curl -s www.es.hu | fgrep '"lapszamvalaszto"')
year=$(echo $AKT_LAPSZAM | sed 's/.*id="lapszamvalaszto">[ \t]*\([^ ]\+\)\..*/\1/')
week=$(echo $AKT_LAPSZAM | sed 's/.*.vfolyam,[ \t]\+\([0-9]\+\)\.[ \t]sz.m.*/\1/')

## DEBUG
# echo $year 
# echo $week
# exit 0

ebook-convert es.recipe es_${year}-${week}.mobi \
              --output-profile kindle \
              --smarten-punctuation \
              --change-justification justify \
              --title "Élet és Irodalom ${year}. ${week}. szám" \
              --toc-title "Tartalom" \
              --remove-paragraph-spacing-indent-size 1.3 \
              --remove-paragraph-spacing \
              --sr1-search ".A vers olvas.s.hoz, k.rj.k, fizessen el..." \
              --sr1-replace "" \
              -vvvvv -d DEBDIR

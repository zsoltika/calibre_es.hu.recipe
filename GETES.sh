#!/bin/bash

# Get the annual weekly id of the newspaper

AKT_LAPSZAM=$(curl -s www.es.hu | fgrep '"lapszamvalaszto"')
year=$(echo $AKT_LAPSZAM | sed 's/.*id="lapszamvalaszto">\([^ ]\+\)\..*/\1/')
week=$(echo $AKT_LAPSZAM | sed 's/.*id="lapszamvalaszto">[^ ]\+\.[^,]\+, \([0-9]\+\)\..*/\1/')

### print debugger
### echo $year $week

ebook-convert es.recipe es_${year}-${week}.mobi \
              --output-profile kindle \
              --smarten-punctuation \
              --change-justification justify \
              --title "Élet és Irodalom ${year}. ${week}. szám" \
              --toc-title "Tartalom" -vvvvvv \
              --remove-paragraph-spacing-indent-size 1.3 \
              --remove-paragraph-spacing \
              --sr1-search ".A vers olvas.s.hoz, k.rj.k, fizessen el..." \
              --sr1-replace ""
ebook-convert es_${year}-${week}.mobi es_L${year}-${week}.pdf \
              --extra-css "body  {background-color: white; color: black; }" \
              --paper-size a4 \
              --smarten-punctuation \
              --change-justification justify \
              --title "Élet és Irodalom ${year}. ${week}. szám" \
              --toc-title "Tartalom" \
              --pretty-print \
              --insert-blank-line \
              --margin-bottom 50.0 \
              --margin-top 50.0 \
              --margin-left 50.0 \
              --margin-right 50.0


#!/usr/bin/env bash

regex='([0-9][.]{0})]'
coverage=$(lcov --summary lcov.info)

[[ ${coverage} =~ $regex ]]

readme=$(<README.md)
percent="${BASH_REMATCH[0]}%25"

echo "[![Coverage](https://badgen.net/badge/coverage/$percent/green?icon=github)](https://badgen.net/badge/coverage/59,9%25/green?icon=github)" > coverage.txt

awk '{sub("{percent}","$percent")}1' $readme > temp.md && mv temp.md README.md

# printf "|\t Code Coverage \t\t\t|\n|\t Development coverage \t| %s |\n|\t Your PR coverage \t| %s |" ${BASH_REMATCH[0]} ${BASH_REMATCH[0]}

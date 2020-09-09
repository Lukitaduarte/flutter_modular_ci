#!/usr/bin/env bash

regex='[0-9].*[%]'
coverage=$(lcov --summary lcov.info)

[[ ${coverage} =~ $regex ]]

echo "# flutter_modular_ci [![Coverage](https://badgen.net/badge/coverage/${BASH_REMATCH[0]}/green?icon=github)](https://badgen.net/badge/coverage/59,9%25/green?icon=github)" > coverage.txt

awk '{sub("%","%25")}' coverage.txt > temp.txt && mv temp.txt coverage.txt

# printf "|\t Code Coverage \t\t\t|\n|\t Development coverage \t| %s |\n|\t Your PR coverage \t| %s |" ${BASH_REMATCH[0]} ${BASH_REMATCH[0]}

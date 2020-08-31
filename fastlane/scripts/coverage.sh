#!/usr/bin/env bash

# sudo apt install lcov

regex='[0-9].*[%]'
coverage=$(lcov --summary lcov.info)

[[ ${coverage} =~ $regex ]]

printf "|\t Code Coverage \t\t\t|\n|\t Development coverage \t| %s |\n|\t Your PR coverage \t| %s |" ${BASH_REMATCH[0]} ${BASH_REMATCH[0]}

echo "|  Branch 	|  Coverage 	|
|---	|---	|
|  Development 	|  ${BASH_REMATCH[0]} 	|
|  Your 	|  ${BASH_REMATCH[0]} 	|" > coverage.txt

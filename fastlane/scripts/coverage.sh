#!/usr/bin/env bash

regex='[0-9].*[%]'
coverage=$(lcov --summary lcov.info)

[[ ${coverage} =~ $regex ]]

echo "# flutter_modular_ci [![Coverage](https://badgen.net/badge/coverage/${BASH_REMATCH[0]}/green?icon=github)](https://badgen.net/badge/coverage/59,9%25/green?icon=github)

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
" > coverage.txt

awk '{sub("%","%25")}1' coverage.txt > temp.txt && mv temp.txt coverage.txt

# printf "|\t Code Coverage \t\t\t|\n|\t Development coverage \t| %s |\n|\t Your PR coverage \t| %s |" ${BASH_REMATCH[0]} ${BASH_REMATCH[0]}

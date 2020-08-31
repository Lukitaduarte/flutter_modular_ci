#!/usr/bin/env bash

error=false

# run unit and widget tests
runTests () {
  local package_dir=$1
  local repo_dir=$2

  cd ${package_dir};

  if [[ -f "pubspec.yaml" ]]; then
    # install flutter dependencies
    flutter packages get

    if [[ -d "test" ]]; then

      escapedPath="$(echo $1 | sed 's/\//\\\//g')"

      # run flutter tests
      if grep flutter pubspec.yaml > /dev/null; then

        echo "Running flutter tests in $1"
        if [ -f "test/all_tests.dart" ]; then
          flutter test --coverage test/all_tests.dart --concurrency=4 || error=true
        else
          flutter test --coverage --concurrency=4 || error=true
        fi

        if [ -d "coverage" ]; then
          # combine line coverage info from package tests to a common file
          sed "s/^SF:lib/SF:$escapedPath\/lib/g" coverage/lcov.info >> $2/lcov.info
          rm -rf "coverage"
        fi

      else
        # run dart tests
        echo "Running dart tests..."
        pub get
        pub run test || error=true
      fi

    fi

  fi

  cd - > /dev/null
}

repo_dir=`pwd`
package_dirs=(`find . -maxdepth 3 -type d`)
for package_dir in "${package_dirs[@]}"; do
    runTests ${package_dir} ${repo_dir}
done

# fail build if there was an error
if [[ ${error} = true ]];
then
    exit -1
fi

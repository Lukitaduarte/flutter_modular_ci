#!/usr/bin/env bash

error=false

cd ..

# run unit and widget tests
runTests () {
  local package_dir=$1
  local repo_dir=$2

  cd ${package_dir};

  if [[ -f "pubspec.yaml" ]] && [[ -d "test" ]]; then
    # install flutter dependencies
    flutter packages get

    # run flutter tests
    if grep flutter pubspec.yaml > /dev/null; then
        echo "Running flutter tests in $1"
        flutter test || error=true
    else
      # run dart tests
      echo "Running dart tests..."
      pub get
      pub run test || error=true
    fi
  fi

  cd - > /dev/null
}

repo_dir=`pwd`
package_dirs=(`find . -maxdepth 2 -type d`)
for package_dir in "${package_dirs[@]}"; do
    runTests ${package_dir} ${repo_dir}
done

# fail build if there was an error
if [[ ${error} = true ]];
then
    exit -1
fi
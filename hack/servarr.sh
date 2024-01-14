#!/usr/bin/env bash

TARGET=${1:-"template"}

install() {
  helm upgrade --install --create-namespace -n media servarr ./charts/servarr -f ./.tmp/values.yaml
}

uninstall() {
  helm uninstall -n media servarr
}

template() {
  helm template -n media servarr ./charts/servarr --debug -f ./.tmp/values.yaml | tee ./.tmp/servarr.yaml | yq
  # code-insiders ./.tmp/servarr.yaml
}

if [ "$TARGET" == "install" ]; then
  install
elif [ "$TARGET" == "template" ]; then
  template
elif [ "$TARGET" == "uninstall" ]; then
  uninstall
else
  echo "Unknown target: $TARGET"
fi

#!/bin/sh

CONFIG=${CONFIG:-"/config/config-base.yaml"}
# SERVER_PORT=${SERVER_PORT:-"$(yq '(.. | .sonarr.server.port) |= envsubst(ne)' -r "${CONFIG}")"}
cat "${CONFIG}" | yq '(.. | select(tag == "!!str")) |= envsubst' > /config/config.yaml
cat /config/config.yaml | yq '{"Config": {"BindAddress": "*", "Port": .sonarr.server.port,"Host": .sonarr.server.address}}' -o xml > /config/config.xml

cat /config/config.yaml | yq
cat /config/config.xml | yq '.'

# yq '(.. | select(tag == "!!str")) |= envsubst | {"Config": {"BindAddress": "*", "Port": .sonarr.server.port,"Host": .sonarr.server.address}}' "${CONFIG}"
# 
# yq '{"Config": {"Port": .sonarr.server.port,"Host": .sonarr.server.address}}' /home/appkins/src/appkins-org/charts/charts/servarr/src/config.yaml
# (.. | select(tag == "!!str")) envsubst(ne)
# cat <<EOF > /config/config.xml
# yq '{"Config": {"Port": env(SERVER_PORT) // .sonarr.server.port}}' /home/appkins/src/appkins-org/charts/charts/servarr/src/config.yaml
# EOF

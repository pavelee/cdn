#!/bin/bash

# https://stackoverflow.com/questions/21056450/how-to-inject-environment-variables-in-varnish-configuration

envs=`printenv`

for env in $envs
do
    IFS== read name value <<< "$env"
    sed -i "s|\${${name}}|${value}|g" /etc/varnish/default.vcl
done

exec "$@"
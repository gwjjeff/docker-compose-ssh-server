#!/usr/bin/env bash
curl -s --unix-socket /var/run/docker.sock "http:/v1.24/containers/json" | jq -r '.[] | {id: .Id[0:12], name: .Names[0][1:], network: .NetworkSettings | .Networks | to_entries[] | { key: .key, value: .value.IPAddress } } | .network.value + " " + .name + "." + .network.key + " " + .id' | sed 's~_~-~g'

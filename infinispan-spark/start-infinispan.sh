#!/bin/bash

IP=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')

exec /usr/local/infinispan-server/bin/standalone.sh -c clustered.xml -Djgroups.bind_addr=$IP -Djboss.bind.address=$IP -b $(hostname -i) "$@"

#!/bin/bash

set -ex

podman run -it --rm --name hx-build -v .:/root/helix-build -w /root/helix-build rust:alpine /root/helix-build/build.sh

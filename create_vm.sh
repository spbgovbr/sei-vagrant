#!/bin/bash

set -e

rm -rf packer || true
vagrant box remove sei-vagrant || true
packer build -force sei-vagrant.json
vagrant box add sei-vagrant ./packer/package.box

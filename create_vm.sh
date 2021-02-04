#!/bin/bash

set -e

rm -rf dist/* || true
vagrant box remove sei-vagrant || true
packer build -force sei-vagrant.json
vagrant box add sei-vagrant ./dist/sei-vagrant.box

#!/bin/bash

set -e

rm packer_virtualbox_virtualbox.box || true
packer build -only=virtualbox packer.json
vagrant box remove vagrant_machine || true
vagrant box add vagrant_machine packer/packer_virtualbox_virtualbox.box

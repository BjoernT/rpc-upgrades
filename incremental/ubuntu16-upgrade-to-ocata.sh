#!/usr/bin/env bash

# Copyright 2018, Rackspace US, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -evu

source lib/vars.sh
source lib/functions.sh

require_ubuntu_version 16

export RPC_BRANCH=${RPC_BRANCH:-'ocata'}
export RPC_PRODUCT_RELEASE="ocata"
export OSA_SHA="stable/ocata"
export SKIP_INSTALL=${SKIP_INSTALL:-"yes"}

mark_started

# here we handle a lot of the cleanup from newton and rpc-o
# to prepare for an OSA deploy
prepare_ocata

checkout_rpc_openstack
checkout_openstack_ansible
ensure_osa_bootstrap

if [[ "$SKIP_INSTALL" == "yes" ]]; then
  mark_completed
  exit 0
fi

repo_rebuild
run_upgrade
mark_completed

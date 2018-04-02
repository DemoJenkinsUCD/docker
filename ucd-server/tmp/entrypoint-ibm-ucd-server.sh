#!/bin/sh

#
#    Copyright 2018 Information Control Company
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
#

# Includes modifications to work licensed under:
#
# (C) Copyright IBM Corporation 2016, 2017.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

file="$UCD_SERVER_HOME/bin/server"
if [ ! -e "$file" ]; then
    echo "Installing IBM UrbanCode Deploy..."
    /tmp/setup-ibm-ucd-server.sh
fi

# Modifications to original IBM script to allow for post-install configuration
file="/tmp/ucd-post-install.sh"
if [ -f "$file" ]; then
    echo "Performing post installation configuration for IBM UrbanCode Deploy..."
    /tmp/ucd-post-install.sh
fi

echo "IBM UrbanCode Deploy is installed"
$UCD_SERVER_HOME/bin/server run

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

cp -v /tmp/appdata/var/plugins/command/stage/* /opt/ibm-ucd/server/appdata/var/plugins/command/stage

cp -fv /tmp/log4j.properties /opt/ibm-ucd/server/appdata/conf/server/log4j.properties

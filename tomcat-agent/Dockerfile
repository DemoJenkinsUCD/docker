#
#    Copyright 2017 Information Control Company
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

FROM tomcat:8.0

USER root

# Configure default users
COPY tomcat-users.xml /usr/local/tomcat/conf/

# Download UrbanCode Deploy agent setup utilities for Docker from GitHub
ADD https://raw.githubusercontent.com/IBM-UrbanCode/UCD-Docker-Images/master/deploy/ga/agent/common/agent-setup.sh /tmp/ucda/
ADD https://raw.githubusercontent.com/IBM-UrbanCode/UCD-Docker-Images/master/deploy/ga/agent/common/startAgent.sh /tmp/ucda/
ADD https://raw.githubusercontent.com/IBM-UrbanCode/UCD-Docker-Images/master/deploy/ga/agent/common/install.properties /tmp/
RUN chmod 655 /tmp/ucda/* && chmod 644 /tmp/install.properties

# Run UrbanCode Deploy agent setup
ARG ucdInstallImageUrl=http://public.dhe.ibm.com/software/products/UrbanCode/Deploy/6.2.2.0/ibm-ucd-agent-6.2.2.0.825094.zip
ARG AGENT_HOME=/opt/ibm-ucd/agent

RUN /tmp/ucda/agent-setup.sh

# Use custom startup script to start both UrbanCode Deploy agent and Tomcat
COPY startAgentTomcat.sh /tmp

CMD ["/tmp/startAgentTomcat.sh"]


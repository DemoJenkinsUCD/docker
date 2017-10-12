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

FROM jenkins/jenkins

USER root

VOLUME /usr/demo

# Copy initialization script that creates default user
ENV JENKINS_USER="ucd_demo" JENKINS_PASS="password"
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/default-user.groovy

# Copy configurations
COPY config/* /usr/share/jenkins/ref/
COPY secrets/* /usr/share/jenkins/ref/secrets/
COPY jenkins-jobs/* /usr/share/jenkins/ref/jenkins-jobs/
COPY ucd-prep/* /usr/share/jenkins/ref/ucd-prep/
ADD ucd-demo-jobs.tar.gz /usr/share/jenkins/ref/jobs/

# Load plugins from update center
COPY install/plugins-*.txt /usr/share/jenkins/install/
RUN install-plugins.sh < /usr/share/jenkins/install/plugins-standard.txt
RUN install-plugins.sh < /usr/share/jenkins/install/plugins-pipeline.txt
RUN install-plugins.sh < /usr/share/jenkins/install/plugins-blueocean.txt

# Load IBM UrbanCode Deploy pipeline plugin
ADD http://public.dhe.ibm.com/software/products/UrbanCode/plugins/ibmucd/jenkins-pipeline-ud-plugin/ibm-ucdeploy-build-steps-2.6.929921.hpi /usr/share/jenkins/ref/plugins/ibm-ucdeploy-build-steps-2.6.929921.jpi
RUN chmod 644 /usr/share/jenkins/ref/plugins/ibm-ucdeploy-build-steps-2.6.929921.jpi

# Make necessary tool installations available
COPY install/tools/ /usr/share/jenkins/install/tools/

# Mark installation as fully configured so Jenkins will skip setup wizard
RUN echo ${JENKINS_VERSION} > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo ${JENKINS_VERSION} > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion

# Install Ruby
# skip installing gem documentation
RUN mkdir -p /usr/local/etc \
	&& { \
		echo 'install: --no-document'; \
		echo 'update: --no-document'; \
	} >> /usr/local/etc/gemrc

ENV RUBY_MAJOR 2.3
ENV RUBY_VERSION 2.3.4
ENV RUBY_DOWNLOAD_SHA256 341cd9032e9fd17c452ed8562a8d43f7e45bfe05e411d0d7d627751dd82c578c
ENV RUBYGEMS_VERSION 2.6.13

# some of ruby's build scripts are written in ruby
#   we purge system ruby later to make sure our final image uses what we just built
RUN set -ex \
	\
	&& buildDeps=' \
		bison \
		build-essential \
		dpkg-dev \
		libgdbm-dev \
		libdbus-glib-1-2 \
		jq \
		ruby \
		ruby-dev \
		xvfb \
	' \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends $buildDeps \
	&& rm -rf /var/lib/apt/lists/* \
	&& gem update --system "$RUBYGEMS_VERSION"

ENV BUNDLER_VERSION 1.15.4

RUN gem install bundler --version "$BUNDLER_VERSION"

# install things globally, for great justice
# and don't create ".bundle" in all our apps
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
	BUNDLE_BIN="$GEM_HOME/bin" \
	BUNDLE_SILENCE_ROOT_WARNING=1 \
	BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH
RUN mkdir -p "$GEM_HOME" "$BUNDLE_BIN" \
	&& chmod 777 "$GEM_HOME" "$BUNDLE_BIN"

#=========
# Firefox
#=========
ARG FIREFOX_VERSION=55.0.3
#RUN apt-get update -qqy \
#  && apt-get -qqy --no-install-recommends install firefox \
#  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
RUN wget --no-verbose -O /tmp/firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2 \
#  && apt-get -y purge firefox \
  && rm -rf /opt/firefox \
  && tar -C /opt -xjf /tmp/firefox.tar.bz2 \
  && rm /tmp/firefox.tar.bz2 \
  && mv /opt/firefox /opt/firefox-$FIREFOX_VERSION \
  && ln -fs /opt/firefox-$FIREFOX_VERSION/firefox /usr/bin/firefox

#============
# GeckoDriver
#============
ARG GECKODRIVER_VERSION=0.16.1
RUN wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GECKODRIVER_VERSION/geckodriver-v$GECKODRIVER_VERSION-linux64.tar.gz \
  && rm -rf /opt/geckodriver \
  && tar -C /opt -zxf /tmp/geckodriver.tar.gz \
  && rm /tmp/geckodriver.tar.gz \
  && mv /opt/geckodriver /opt/geckodriver-$GECKODRIVER_VERSION \
  && chmod 755 /opt/geckodriver-$GECKODRIVER_VERSION \
  && ln -fs /opt/geckodriver-$GECKODRIVER_VERSION /usr/bin/geckodriver


USER jenkins

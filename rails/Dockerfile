FROM        ruby:2.5
MAINTAINER  Michael B. Klein <michael.klein@northwestern.edu>
RUN         apt-get update && apt-get install -y locales sudo
RUN         groupadd -r app && useradd -r -g app app
WORKDIR     /home/app/code
RUN         chown -R app:app /home/app
ADD         rails-entrypoint.sh /
ENTRYPOINT  "/rails-entrypoint.sh"
#HEALTHCHECK --interval=30s --timeout=5s \
#  CMD curl -f http://localhost:3000/ exit 1

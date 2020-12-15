FROM nnarain/ros2-desktop:latest

ENV SCRIPTS_DIR /tmp/scripts
# Copy over setup scripts
COPY ./common/* ${SCRIPTS_DIR}/
RUN export PATH=$PATH:/tmp/scripts

# Setup dev environment
RUN apt-get update \
    && sh ${SCRIPTS_DIR}/setup-common.sh ${SCRIPTS_DIR} \
    && rm -rf /tmp/scripts

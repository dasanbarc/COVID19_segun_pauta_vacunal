FROM ubuntu:20.04
WORKDIR /usr/src/covid_data
COPY . .
RUN apt-get update
RUN apt-get install wget jq gawk csvkit -y
#CMD ["./run.sh"]


# Bibliografía:
# https://askubuntu.com/questions/874611/installing-multiple-packages-at-the-same-time
# https://stackoverflow.com/questions/43419500/how-do-you-start-a-docker-ubuntu-container-into-bash/43420931
# https://phoenixnap.com/kb/docker-cmd-vs-entrypoint

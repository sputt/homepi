FROM homeseer-image

WORKDIR /home/pi/HomeSeer
COPY HomeSeerBackup_2_13_2018-6_48.zip ./
RUN unzip -o -d /tmp/backup/ HomeSeerBackup_2_13_2018-6_48.zip
RUN unzip -o -d Data/ /tmp/backup/Data.zip && \
    unzip -o -d Config/ /tmp/backup/Config.zip && \
    unzip -o -d scripts/ /tmp/backup/scripts.zip

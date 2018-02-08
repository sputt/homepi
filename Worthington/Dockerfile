FROM homeseer-image

WORKDIR /home/pi/HomeSeer
COPY HomeSeerBackup.zip ./
RUN unzip -o -d /tmp/backup/ HomeSeerBackup.zip
RUN unzip -o -d Data/ /tmp/backup/Data.zip && \
    unzip -o -d Config/ /tmp/backup/Config.zip && \
    unzip -o -d scripts/ /tmp/backup/scripts.zip

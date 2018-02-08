FROM arm32v7/debian:stretch

RUN apt-get update -qq && \
    apt-get install -y gnupg && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb http://download.mono-project.com/repo/debian raspbianstretch main" | tee /etc/apt/sources.list.d/mono-official.list && \
    apt-get update -qq && \
    apt-get install -y mono-complete mono-vbnc
RUN apt-get install -y screen sudo unzip

WORKDIR /home/pi
COPY hs3_linux_3_0_0_368.tar.gz ./
RUN tar xf hs3_linux_3_0_0_368.tar.gz

WORKDIR /home/pi/HomeSeer
COPY HSPI_ZWave.exe ./
COPY Z-Wave ./bin/Z-Wave/

EXPOSE 80
CMD ["mono", "HSConsole.exe", "--log"]

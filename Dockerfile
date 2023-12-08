FROM ubuntu:latest

WORKDIR /DyPyBench

RUN apt-get update

RUN apt-get install python3 -yq

RUN apt install python3-pip -yq

RUN apt install python3-virtualenv -yq

RUN apt install libjpeg8-dev -yq

RUN apt install git -yq

RUN apt install nano -yq

RUN apt-get install ffmpeg libavcodec-extra -yq

RUN pip install --upgrade pip setuptools wheel

COPY . .

RUN chmod -R 777 ./scripts 
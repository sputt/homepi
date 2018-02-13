FROM python:2-alpine3.7
RUN apk --no-cache add musl-dev gcc

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python", "-u", "./poll_gpio.py" ]

from collections import namedtuple
import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)

PinMapping = namedtuple("PinMapping", "pin name hsid")

INPUT_PINS = [
    PinMapping(24, 'Water Sensor', 67)
]

for mapping in INPUT_PINS:
    GPIO.setup(mapping.pin, GPIO.IN)

while True:
    for mapping in INPUT_PINS:
        val = GPIO.input(mapping.pin)
        print val
    time.sleep(0.5)

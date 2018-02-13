from collections import namedtuple
import RPi.GPIO as GPIO
import time
import requests

INPUT_DEBOUNCE_MS = 200

GPIO.setmode(GPIO.BCM)

PinMapping = namedtuple('PinMapping', 'pin name hsid')

INPUT_PINS = [
    PinMapping(24, 'Water Sensor', 3),
    PinMapping(23, 'Kitchen Door', 84)
]


def post_to_homeseer(hsid, value):
    resp = requests.get('http://homeseer/JSON?request=controldevicebyvalue&ref={hsid}&value={value}'.format(
        **locals()
    ))
    print 'Posted, resp = {}'.format(resp.status_code)


def edge_callback(pin):
    mapping = pins[pin]
    val = GPIO.input(pin)
    print '{} = {}'.format(mapping.name, val)
    post_to_homeseer(mapping.hsid, (1 - val) * 100)


def poll_now():
    for mapping in INPUT_PINS:
        edge_callback(mapping.pin)


print 'Starting GPIO monitoring'
pins = {}
for mapping in INPUT_PINS:
    GPIO.setup(mapping.pin, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
    pins[mapping.pin] = mapping
    GPIO.add_event_detect(mapping.pin, GPIO.BOTH,
                          edge_callback)

# Poll every 15 minutes
while True:
    poll_now()
    time.sleep(15.0 * 60.0)

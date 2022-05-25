#!/usr/bin/python

import random
import time

while True:
    random.seed()
    random_sleep_interval = random.randint(100, 150)
    print('got random interval to sleep: {}'.format(random_sleep_interval))
    time.sleep(random_sleep_interval)


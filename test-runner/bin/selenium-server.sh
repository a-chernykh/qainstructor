#!/bin/bash

docker run --name selenium-server --dns 192.168.1.238 -d -p 4444:4444 selenium/standalone-firefox:2.48.2

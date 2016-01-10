#!/bin/bash

./letsencrypt-auto certonly --standalone -d qainstructor.com \
                                         -d www.qainstructor.com \
                                         -d faye.qainstructor.com \
                                         -d message.sample.qainstructor.com \
                                         -d app.sample.qainstructor.com \
                                         -d example3.sample.qainstructor.com \
                                         -d secret.sample.qainstructor.com \
                                         -d bomb.sample.qainstructor.com \
                                         -d html.sample.qainstructor.com \
                                         -d slow.sample.qainstructor.com

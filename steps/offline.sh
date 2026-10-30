#!/usr/bin/env bash
# offline: prove the wifi is off and the model is still here.
networksetup -getairportpower en0
ping -c 1 -t 2 google.com
curl -s 127.0.0.1:8000/v1/models | grep -o '"name":"[^"]*"' | head -1

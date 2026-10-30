#!/usr/bin/env bash
# offline: prove the wifi is off and the model is still here.
networksetup -getairportpower en0
ping -c 1 -t 2 google.com
curl -s localhost:11434/v1/models | grep -o '"id":"gemma4:12b-mlx"'

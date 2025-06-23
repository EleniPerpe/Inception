#!/bin/bash

ln -sf "/etc/nginx/sites-available/default" "/etc/nginx/sites-enabled/default"
nginx -t
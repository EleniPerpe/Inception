#!/bin/bash

ln -sf "$SITES_DIR/default" "/etc/nginx/sites-enabled/default"
nginx -t
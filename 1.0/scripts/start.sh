#!/usr/bin/env bash
set -e

crond &
httpd-foreground
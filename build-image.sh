#!/bin/sh

# Container version: arbitrary
VERSION=1.0

# build the dockerfile into an image
docker build -t futuralogic/mcrcon:$VERSION .
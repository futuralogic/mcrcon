#!/bin/sh

# Container version: arbitrary
VERSION=latest

# build the dockerfile into an image
docker build -t futuralogic/mcrcon:$VERSION .

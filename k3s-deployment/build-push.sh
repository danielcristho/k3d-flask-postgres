#!/bin/env bash

docker build -t danielcristh0/flask-todo:latest flask-todo
docker push danielcristh0/flask-todo:latest
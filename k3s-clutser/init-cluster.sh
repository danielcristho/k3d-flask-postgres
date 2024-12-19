#!/bin/env bash

sudo k3s kubectl create namespace flask-todo
sudo k3s kubectl label node k3s-master role=master
sudo k3s kubectl label node k3s-app1 role=app
sudo k3s kubectl label node k3s-app2 role=app
sudo k3s kubectl label node k3s-db role=db
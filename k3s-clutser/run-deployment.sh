#!/bin/env bash

sudo k3s kubectl apply -f deployment/nginx-config.yaml
sudo k3s kubectl apply -f deployment/flask-deployment.yaml
sudo k3s kubectl apply -f deployment/postgres-deployment.yaml
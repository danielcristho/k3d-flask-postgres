#!/bin/env bash

kubectl apply \
    -f deployment/postgres-deployment.yaml \
    -f deployment/flask-deployment.yaml \
    -f deployment/nginx-configmap.yaml \
    -f deployment/nginx-deployment.yaml
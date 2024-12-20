#!/bin/env bash

k3d cluster create --config manifests/create-config.yaml

kubectl label node k3d-flask-todo-agent-0 role=lb && \
kubectl label node k3d-flask-todo-agent-1 role=app && \
kubectl label node k3d-flask-todo-agent-2 role=app && \
kubectl label node k3d-flask-todo-agent-3 role=db


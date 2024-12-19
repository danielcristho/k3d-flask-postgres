#!/bin/env bash

sudo kubectl delete deployment flask-todo
sudo kubectl delete deployment nginx-todo-lb
sudo kubectl delete service flask-todo-service
sudo kubectl delete configmap nginx-todo-config
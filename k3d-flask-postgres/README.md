# Create and manage local cluster using KIND and K3D

## Kind

## Deploy Flask App using K3D

## Architecture

![aristektur-cc](https://github.com/user-attachments/assets/46b3ae10-bf6a-45c8-99a7-2382b48532b2)

## How to run

Install docker, kubectl & k3d.

```bash
$ cd k3d-flask-postgres
$ ./install-k3d.sh
```

Create cluster.

```bash
$ ./up-cluster

INFO[0000] Using config file manifests/create-config.yaml (k3d.io/v1alpha5#simple)
INFO[0000] Prep: Network
INFO[0000] Created network 'k3d-flask-todo'
INFO[0000] Created image volume k3d-flask-todo-images
INFO[0000] Starting new tools node...
INFO[0000] Starting node 'k3d-flask-todo-tools'
INFO[0001] Creating node 'k3d-flask-todo-server-0'
INFO[0001] Creating node 'k3d-flask-todo-agent-0'
INFO[0001] Creating node 'k3d-flask-todo-agent-1'
INFO[0001] Creating node 'k3d-flask-todo-agent-2'
INFO[0001] Creating node 'k3d-flask-todo-agent-3'
INFO[0001] Creating LoadBalancer 'k3d-flask-todo
....
```

Verify the result using `docker ps` & `k3d cluster list`:

```bash
$ docker ps

CONTAINER ID   IMAGE                            COMMAND                  CREATED              STATUS              PORT
S                                                                                                    NAMES
bc088cd452d9   ghcr.io/k3d-io/k3d-proxy:5.7.4   "/bin/sh -c nginx-pr…"   About a minute ago   Up About a minute   80/t
cp, 0.0.0.0:30000-30100->30000-30100/tcp, :::30000-30100->30000-30100/tcp, 0.0.0.0:35331->6443/tcp   k3d-flask-todo-se
rverlb
62d801443640   rancher/k3s:v1.30.4-k3s1         "/bin/k3d-entrypoint…"   About a minute ago   Up About a minute
                                                                                                     k3d-flask-todo-ag
ent-3
4dfa19aa6fb3   rancher/k3s:v1.30.4-k3s1         "/bin/k3d-entrypoint…"   About a minute ago   Up About a minute
                                                                                                     k3d-flask-todo-agent-2
7531e3471050   rancher/k3s:v1.30.4-k3s1         "/bin/k3d-entrypoint…"   About a minute ago   Up About a minute                                                                                                            k3d-flask-todo-agent-1
264be25551c4   rancher/k3s:v1.30.4-k3s1         "/bin/k3d-entrypoint…"   About a minute ago   Up About a minute                                                                                                            k3d-flask-todo-agent-0
6198f25ac6eb   rancher/k3s:v1.30.4-k3s1         "/bin/k3d-entrypoint…"   About a minute ago   Up About a minute                                                                                                            k3d-flask-todo-server-0
```

```bash
$ k3d cluster list

NAME         SERVERS   AGENTS   LOADBALANCER
flask-todo   1/1       4/4      true
```

Exposing services using NodePort.

```bash
$ ./expose-service.sh

```

Create Deployment.

```bash
$ ./create-deployment.sh

deployment.apps/postgres created
service/db created
deployment.apps/flask-todo created
service/flask-todo created
configmap/nginx-config created
deployment.apps/nginx created
service/nginx created
```




# Create and manage local cluster using KIND (Kubernetes IN Docker) and K3D (K3s IN Docker)

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

After that, make the pods are running.

```bash
$ kubectl get pods

NAME                          READY   STATUS    RESTARTS      AGE
flask-todo-795549f474-llm6q   1/1     Running   3 (25m ago)   28m
flask-todo-795549f474-zwqbw   1/1     Running   4 (25m ago)   28m
nginx-fd54c6fff-kstjf         1/1     Running   0             28m
postgres-5797cf68b9-sc2sc     1/1     Running   0
```

Get Services.

```bash
$ kubectl get svc

NAME         TYPE           CLUSTER-IP      EXTERNAL-IP                                              PORT(S)
AGE
db           ClusterIP      10.43.191.205   <none>                                                   5432/TCP
21m
flask-todo   ClusterIP      10.43.211.20    <none>                                                   5000/TCP
21m
kubernetes   ClusterIP      10.43.0.1       <none>                                                   443/TCP
22m
nginx        LoadBalancer   10.43.49.180    172.22.0.2,172.22.0.3,172.22.0.4,172.22.0.5,172.22.0.6   8082:31951/TCP
21m
```

Try to accesing the app from browser using `LoadBalancer EXTERNAL-IP`.

```sh
http://172.22.0.8082
```

![access from browser](https://github.com/user-attachments/assets/ea3aceeb-07f6-4adc-8197-52c1f7f02dcb)

And acess the database.

![psql-db](https://github.com/user-attachments/assets/19afd963-3b8a-44f5-bd0b-593ae8d2ddec)

Add Kubernetes Dashboard using Octant.

```bash
./octant-dashboard.sh
```

Result:

![octant-ui](https://github.com/user-attachments/assets/dd040f9f-0984-4c38-ab62-cd7101f3099a)

![octant ui](https://github.com/user-attachments/assets/ca0df247-1184-42b7-8f78-5f171ec0f2c5)

## Kind Cases
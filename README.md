# Using the lightweight-coscheduler for realises.

Based on scheduler from:

    github.com/kubernetes-sigs/scheduler-plugins/blob/release-1.18/pkg/coscheduling/README.md

Steps:

```sh
# fresh cluster
kind delete cluster
kind create cluster

# get logs from the default scheduler
kubectl logs --namespace kube-system pod/kube-scheduler-kind-control-plane

# create a service account for this scheduler
kubectl apply -f rbac.yaml
# undo with: kubectl delete clusterrolebinding.rbac.authorization.k8s.io/lightweight-coscheduler

# create a config-map with our scheduler config:
kubectl apply -f scheduler_config.yaml
# check with: kubectl describe configmaps scheduler-config
# undo with: kubectl delete configmap/scheduler-config

# deploy the scheduler
kubectl apply -f deployment.yaml
# undo with: kubectl delete deployment/lightweight-coscheduler

#### Control group: launch a pod against the normal scheduler.
kubectl apply -f sayhi-default.yaml
kubectl logs sayhi-default
kubectl describe pods sayhi-default
# cool, now delete that pod
kubectl delete pods/sayhi-default

#### Same thing on the custom scheduler, with 2 commit.
kubectl apply -f sayhi-custom1.yaml
# run kubectl get pods to show that pod still pending
kubectl apply -f sayhi-custom2.yaml
# run kubectl get pods to show that both pods ran
kubectl get pods

# oh shit, that didn't work, redeploy the scheduler and it works
kubectl delete deployment/lightweight-coscheduler
kubectl apply -f deployment.yaml
```


# Cheat sheet from ~/notes/notes

kubectl get events

kubectl apply -f PODNAME.yaml
kubectl describe pods PODNAME
kubectl logs PODNAME
kubectl delete PODNAME

kubectl describe nodes kind-control-plane

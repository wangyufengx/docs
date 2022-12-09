# kubectl 基本命令
### 查询节点列表
kubectl get node

### 查询节点信息
kubectl describe node nodeName

### 查看pod应用的信息
kubectl describe pod pod名称  

### 查看pod日志
kubectl logs -f  pod名称 -n 命名空间

### 查看集群事件
kubectl get events


### 查看服务信息
kubectl get svc  -o wide -n 命名空间
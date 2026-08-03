# Lab 6 - Checkpoint Questions Answers

### Checkpoint Q1: Control Plane vs Worker Node
* **Control Plane:** The brain of the Kubernetes cluster. It makes global decisions (e.g., scheduling), detects and responds to cluster events (e.g., starting a new pod when a replica count isn't satisfied).
* **Worker Node:** The muscle of the cluster. It maintains running pods and provides the Kubernetes runtime environment (Kubelet, Kube-proxy, Container Runtime).

---

### Checkpoint Q2: Pod Ephemerality and IP Changes
* **Observation:** Yes, the IP address changed.
* **Explanation:** Pods are ephemeral and mortal. They are created, assigned a dynamic IP, and destroyed. When a Pod is recreated, Kubernetes treats it as a completely new execution unit and assigns a brand-new IP address.

---

### Checkpoint Q3: Control-Loop Model for Self-Healing
1. **Desired State:** Deployment specifies `replicas: 3`.
2. **Controller Watches:** The Deployment/ReplicaSet controller continuously monitors the cluster state.
3. **Actual State:** Deleting a pod drops actual count to `2`.
4. **Gap Detected:** Desired (3) != Actual (2).
5. **Reconcile:** The ReplicaSet controller instructs the Scheduler/Kubelet to spin up a new Pod immediately to restore the desired state.

---

### Checkpoint Q4: Scaling Frontend Independently
* Frontend pods are completely **stateless**. They do not hold application data directly. Scaling the frontend up/down only adjusts web request handler instances and communicates with the backend/database via persistent Services without affecting DB storage or state.

---

### Checkpoint Q5: Port-Forward vs Kubernetes Service
* **Port-Forward:** Direct debugging link from local localhost to a specific single Pod IP/Port. If the pod dies, the link breaks.
* **Service:** An abstraction layer with a stable virtual IP and DNS name. It load-balances traffic dynamically across all underlying pods matching a selector, even as pods die and get replaced with new IPs.

---

### Checkpoint Q6: Rolling Updates vs Docker Compose
* Docker Compose lacks built-in orchestration control-loops for zero-downtime rolling updates and automatic health-checked rollbacks. Kubernetes handles incremental pod substitution (updating 1-by-1) and automated rollback (`kubectl rollout undo`) out of the box if deployment health checks fail.

---

### Checkpoint Q7: Deployment vs StatefulSet
* **Deployment:** Used for stateless tiers (Frontend, API). Pods are interchangeable, have random hashes in names (`frontend-7cd4b4575b-f82vs`), and share no unique state.
* **StatefulSet:** Used for stateful tiers (PostgreSQL). Guarantees stable unique network identifiers (`postgres-0`), ordered graceful deployment/scaling, and automated binding to persistent storage (PVC) that sticks to the identity upon pod recreation.

---

### Checkpoint Q8: Data Survival without PVC
* **No**, data would **NOT** have survived. Without a PersistentVolumeClaim (PVC), database files are written to the ephemeral container writable layer. Deleting `postgres-0` destroys the container filesystem entirely.

---

### Checkpoint Q9: Broken Pod Status
* **Status:** `ErrImagePull` / `ImagePullBackOff`.
* **Meaning:** It is a specific sub-state of `Pending`. `ErrImagePull` means Kubelet failed to pull the specified image tag from Docker Hub. `ImagePullBackOff` means Kubernetes is backing off and retrying the pull with exponential delay.
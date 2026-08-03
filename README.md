# CIT-24-01-0089 - Cloud & Virtualization Architecture Assignment

**Student Name:** Waruna Chandima  
**Degree Program:** B.Sc. (Hons) in Cyber Security  
**Institution:** Sri Lanka Technological Campus (SLTC)  
**Module:** Virtualization & Cloud Technologies (CIT-24-01-0089)

---

## 📌 Executive Summary

This repository contains the complete implementation, automation scripts, deployment manifests, and verification workflows for two primary virtualization assignments:
1. **Docker Web Application Assignment:** Multi-container orchestration using Flask, Redis, custom bridge networks, and persistent storage.
2. **Lab 6 (Kubernetes):** Production-like multi-tier application deployment, scaling, rolling updates, stateful storage, and cluster debugging on Minikube.

---

## 🐳 Part 1: Docker Web Application Assignment

### 📖 Application Description
A multi-container Docker web application utilizing a Python (Flask) web frontend (`web-app`) and an in-memory Redis database (`redis-db`) for maintaining stateful visit counts.

### ⚙️ Network and Volume Details
* **Network:** `app-net` (Custom Bridge network for container-to-container communication)
* **Volume:** `redis-data` (Persistent named volume attached to `/data` in Redis for data retention)

### 📦 Container Configuration
1. **`web-app`**: Custom-built Flask container running on Port `5000`, connected to `redis-db`.
2. **`redis-db`**: Official `redis:alpine` container running internally on Port `6379` with persistence enabled (`--appendonly yes`).

### 📜 Execution Scripts Overview

* **`prepare-app.sh`**: Creates the `app-net` bridge network and `redis-data` volume.
* **`start-app.sh`**: Builds the custom Flask Docker image and runs both `redis-db` and `web-app` containers.
* **`stop-app.sh`**: Safely stops running containers while preserving persistent volumes and state.
* **`remove-app.sh`**: Cleans up all resources, containers, networks, and persistent volumes.

---

## ☸️ Part 2: Lab 6 - Kubernetes Multi-Tier Application Deployment

### 🏗️ Architecture Overview

The Kubernetes environment consists of the following decoupled tiers managed via declarative YAML manifests:

* **Frontend Tier:** Nginx-based Web Application (Exposed externally via NodePort Service)
* **Backend Tier:** Node.js Express API Service
* **Caching Tier:** Redis In-Memory Cache
* **Database Tier:** PostgreSQL Stateful Application with Persistent Volume Claim (PVC)

### 📁 Kubernetes Directory Structure

```text
.
├── k8s/
│   ├── frontend.yaml            # Deployment for Frontend Nginx
│   ├── service-frontend.yaml    # NodePort Service for Frontend
│   ├── api.yaml                 # Backend API Deployment & Service
│   ├── cache.yaml               # Redis Cache Deployment & Service
│   ├── postgres.yaml            # PostgreSQL StatefulSet & Service
│   └── broken-pod.yaml          # Test manifest for ImagePullBackOff debugging
├── prepare-app.sh               # Docker resource preparation script
├── start-app.sh                 # Docker deployment script
├── stop-app.sh                  # Docker stop script
├── remove-app.sh                # Docker cleanup script
└── README.md                    # Project Documentation
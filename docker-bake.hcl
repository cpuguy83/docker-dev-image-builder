variable "DOCKER_REPO" {
  default = "https://github.com/docker/docker.git"
}

variable "DOCKER_REF" {
  default = "master"
}

variable "REPO_BASE" {
  default = "ghcr.io/cpuguy83/docker"
}

group "default" {
    targets = ["dev"]
}

function "cacheTo" {
    params = [name]
    result = [format("type=registry,mode=max,ref=${REPO_BASE}/%s:${DOCKER_REF}-cache", name)]
}

function "cacheFrom" {
    params = [name]
    result = ["type=gha", format("type=registry,ref=${REPO_BASE}/%s:${DOCKER_REF}-cache", name)]
}

function "tags" {
    params = [name]
    result = [format("${REPO_BASE}/%s:${DOCKER_REF}", name)]
}

function "output" {
    params = []
    result = ["type=registry,push=true"]
}

function "dockerContext" {
    params = []
    result = "${DOCKER_REPO}#${DOCKER_REF}"
}

target "criu" {
    context = dockerContext()
    target = "criu"
    tags = tags("criu")
    output = output()
    cache-from = cacheFrom("criu")
    cache-to = cacheTo("criu")
}

target "tini" {
    context = dockerContext()
    target = "tini"
    tags = tags("tini")
    output = output()
    cache-from = cacheFrom("tini")
    cache-to = cacheTo("tini")
}

target "registry" {
    context = dockerContext()
    target = "registry"
    tags = tags("registry")
    output = output()
    cache-from = cacheFrom("registry")
    cache-to = cacheTo("registry")
}

target "runc" {
    context = dockerContext()
    target = "runc"
    tags = tags("runc")
    output = output()
    cache-from = cacheFrom("runc")
    cache-to = cacheTo("runc")
}

target "containerd" {
    context = dockerContext()
    target = "containerd"
    tags = tags("containerd")
    output = output()
    cache-from = cacheFrom("containerdev")
    cache-to = cacheTo("containerd")
}

target "golangci_lint" {
    context = dockerContext()
    target = "golangci_lint"
    tags = tags("golangci_lint")
    output = output()
    cache-from = cacheFrom("golangci_lint")
    cache-to = cacheTo("golangci_lint")
}

target "dev" {
    context = dockerContext()
    target = "dev"
    tags = tags("dev")
    output = output()
    cache-from = cacheFrom("dev")
    cache-to = cacheTo("dev")
}
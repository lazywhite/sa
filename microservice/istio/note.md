component
    envoy
    mixer
        enforce access control and usage policies
    pilot
        service discovery for envoy sidecar
        traffic management capabilities for routing
        resilience(timeout, retry, circiut breaker)

    citaldel
        traffic encryption


# enable jaeger
istioctl manifest apply --set profile=demo  --set values.tracing.enabled=true
# should enable grafana, prometheus

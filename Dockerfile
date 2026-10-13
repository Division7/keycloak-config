FROM quay.io/keycloak/keycloak:latest AS builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
WORKDIR /app
ENV KC_DB=postgres
COPY --from=builder /opt/keycloak/ /opt/keycloak/
COPY startup.sh .

ENTRYPOINT ["/app/startup.sh"]
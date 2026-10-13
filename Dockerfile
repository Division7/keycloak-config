FROM quay.io/keycloak/keycloak:latest AS builder

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
WORKDIR /app
ENV KC_DB=postgres
COPY --from=builder /opt/keycloak/ /opt/keycloak/
COPY keycloak.conf /opt/keycloak/conf/keycloak.conf
COPY startup.sh .
ENTRYPOINT ["/app/startup.sh"]
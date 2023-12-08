FROM registry.ci.openshift.org/ocp/builder:rhel-8-golang-1.17-openshift-4.10 AS builder
WORKDIR /go/src/github.com/borball/vdu-caas-must-gather
COPY . .

FROM registry.ci.openshift.org/ocp/4.10:must-gather
LABEL io.k8s.display-name="vdu-caas-must-gather" \
      io.k8s.description="This is a must-gather image that collects important vDU required & tuned resources."
COPY --from=builder /go/src/github.com/borball/vdu-caas-must-gather/collection-scripts/* /usr/bin/
RUN chmod +x /usr/bin/gather

ENTRYPOINT /usr/bin/gather
FROM alpine:latest
ENV ISTIO_VERSION 1.6.0
RUN apk update && apk add curl bash
RUN curl -L https://istio.io/downloadIstio | sh -
RUN mv istio-${ISTIO_VERSION}/bin/istioctl /usr/bin && chmod +x /usr/bin/istioctl
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
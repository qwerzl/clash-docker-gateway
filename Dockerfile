FROM --platform=${BUILDPLATFORM} dreamacro/clash:latest as builder

FROM alpine:latest
LABEL org.opencontainers.image.source="https://github.com/qwerzl/clash-docker-gateway"
RUN apk add iptables
COPY ./iptables.sh /
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /root/.config/clash/Country.mmdb /root/.config/clash/Country.mmdb 
COPY --from=builder /clash /
ENTRYPOINT ["sh","/iptables.sh","&&","/clash"]

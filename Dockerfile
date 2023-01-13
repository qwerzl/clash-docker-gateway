FROM --platform=${BUILDPLATFORM} dreamacro/clash:latest as builder

FROM alpine:latest
LABEL org.opencontainers.image.source="https://github.com/Dreamacro/clash"
COPY ./iptables.sh /
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /Country.mmdb /root/.config/clash/
COPY --from=builder /clash /
ENTRYPOINT ["sh","/iptables.sh","&&","/clash"]

FROM h2non/imaginary:latest AS imaginary

FROM nginx:latest

RUN apt-get update && \
    apt-get install -y libvips42 \
    supervisor

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=imaginary /usr/local/bin/imaginary /usr/local/bin/imaginary

COPY supervisor.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
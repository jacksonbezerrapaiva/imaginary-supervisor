
FROM h2non/imaginary:latest AS imaginary

FROM nginx:latest

# Instalar libvips para dependências do Imaginary
RUN apt-get update && \
    apt-get install -y libvips42 \
    supervisor

# Copiar o arquivo nginx.conf para a configuração do NGINX
COPY nginx.conf /etc/nginx/nginx.conf

# Copiar o binário do Imaginary da etapa anterior
COPY --from=imaginary /usr/local/bin/imaginary /usr/local/bin/imaginary

# Adicionar um arquivo de configuração do supervisor para gerenciar os processos
COPY supervisor.conf /etc/supervisor/conf.d/supervisord.conf

# Expor as portas 80 (NGINX) e 9000 (Imaginary)
EXPOSE 80 9000

# Iniciar o supervisord, que vai gerenciar o NGINX e o Imaginary
CMD ["/usr/bin/supervisord"]
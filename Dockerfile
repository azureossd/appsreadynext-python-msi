FROM python:3.8.7-slim-buster

WORKDIR /app
COPY . .
RUN pip install -r requirements.txt && pip install gunicorn

# ssh
ENV SSH_PASSWD "root:Docker!"
RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
	&& echo "$SSH_PASSWD" | chpasswd 

COPY sshd_config /etc/ssh/
COPY init.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/init.sh

ENV PORT=8080
EXPOSE 8080 2222

ENTRYPOINT ["/usr/local/bin/init.sh"]
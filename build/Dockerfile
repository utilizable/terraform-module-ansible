FROM alpine:latest

# Install tools
RUN apk             \
    --update        \
    --no-cache      \
    add             \
    openssh-client  \
    sshpass         \
    bash            \
    py3-jmespath    \ 
    git             \
    curl

# Install ansible
RUN apk 						\
		--no-cache 			\
		add 						\
		ansible

# Install terraform
RUN release="$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1')" \
    && wget https://releases.hashicorp.com/terraform/${release}/terraform_${release}_linux_amd64.zip \
    && unzip terraform_${release}_linux_amd64.zip \
    && mv terraform /usr/bin/terraform

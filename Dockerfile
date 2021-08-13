FROM ubuntu:20.04

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USER_NAME=appuser

# Dependencies

RUN apt-get update && apt-get install -y \
    curl \
    git \
    tmux \
    make \
    vim \
    zsh \
    && apt-get autoremove -y

# User

RUN addgroup --gid ${GROUP_ID} ${USER_NAME} \
    && adduser --home "/home/${USER_NAME}" --uid "${USER_ID}" --gid "${GROUP_ID}" "${USER_NAME}" \
    && usermod  --password $(echo "password" | openssl passwd -1 -stdin) "${USER_NAME}" \
    && chsh "${USER_NAME}" -s $(which zsh)

USER ${USER_NAME}

WORKDIR "/home/${USER_NAME}"

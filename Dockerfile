FROM ubuntu:22.04

ARG USER_NAME="user"
ARG USER_ID="1500"
ARG GROUP_NAME="group"
ARG GROUP_ID="1500"
ARG PASSWORD="password"

ARG USER_NAME USER_ID GROUP_NAME GROUP_ID PASSWORD IMAGE_NAME

RUN if [ -z "${USER_NAME}"  ] || \
       [ -z "${IMAGE_NAME}"   ];   \
    then echo "Please specify args"; \
    exit 1; \
    fi

# basic
RUN apt update -y

# add user and group
RUN groupadd -g ${GROUP_ID} ${GROUP_NAME}
RUN useradd -u ${USER_ID} -g ${GROUP_ID} -m ${USER_NAME}
RUN echo "$USER_NAME:$PASSWORD" | chpasswd

# ESP-IDF Prerequisites
RUN apt install -y git wget flex bison gperf python3 python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0

# Get ESP-IDF
USER ${USER_ID}
RUN mkdir -p ~/esp
RUN git clone --recursive https://github.com/espressif/esp-idf.git -b v5.0.2 ~/esp/esp-idf

# ESP-IDF Set up the tools
RUN ~/esp/esp-idf/install.sh esp32
RUN echo "alias get_idf='. $HOME/esp/esp-idf/export.sh'" > ~/.bash_aliases

# Set Prompt
RUN echo PS1="'(docker)${IMAGE_NAME}:\w${PS1}'" >> ~/.bashrc

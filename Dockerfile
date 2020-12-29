FROM debian:latest as builder
RUN apt update  -y &&\
    apt upgrade -y &&\ 
    apt install -y curl\
                   tmux

# install sbcl
RUN apt install -y sbcl

# install quicklisp
RUN curl -o /tmp/ql.lisp http://beta.quicklisp.org/quicklisp.lisp
RUN sbcl --no-sysinit --no-userinit --load /tmp/ql.lisp \
         --eval '(quicklisp-quickstart:install :path "~/.quicklisp")' \
         --eval '(ql:add-to-init-file)' \
         --quit

# Copy the config
COPY config/ root/ 

# Set the workdir
WORKDIR root/.quicklisp/local-projects

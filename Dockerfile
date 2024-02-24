# syntax = docker/dockerfile:1.2

# Nix builder
FROM nixos/nix:latest AS builder

# Copy our source and setup our working dir.
COPY . /tmp/build
WORKDIR /tmp/build

# Build our Nix environment
RUN nix \
    --extra-experimental-features "nix-command flakes" \
    --option filter-syscalls false \
    build

# Copy the Nix store closure into a directory. The Nix store closure is the
# entire set of Nix store values that we need for our build.
RUN mkdir /tmp/nix-store-closure
RUN cp -R $(nix-store -qR result/) /tmp/nix-store-closure

# Final image is based on scratch. We copy a bunch of Nix dependencies
# but they're fully self-contained so we don't need Nix anymore.
FROM scratch

WORKDIR /app

# Copy /nix/store
COPY --from=builder /tmp/nix-store-closure /nix/store
COPY --from=builder /tmp/build/result /app
CMD ["/app/bin/app"]

# FROM ocaml/opam:debian-10-ocaml-4.13
# RUN sudo apt install -y libcurl4-gnutls-dev libgmp-dev

# WORKDIR /lang_agent/
# RUN opam install dune


# # sudo docker run -it lang_agent bash 
# ENV PATH /home/opam/.opam/4.13/bin/:$PATH
# RUN /home/opam/.opam/4.13/bin/dune --version
# #RUN apt-get -y install opam


# RUN opam repo add coq-released https://coq.inria.fr/opam/released
# RUN opam repo add coq-extra-dev https://coq.inria.fr/opam/extra-dev
# RUN opam install --yes ppx_yojson_conv_lib coq
# RUN opam install --yes ppx_yojson lwt_ppx containers lambdasoup uri ezcurl ppx_yojson_conv ppx_yojson_conv_lib ezcurl-lwt yojson
# RUN opam install --yes coq-metacoq-template
# RUN opam pin add --yes openai https://github.com/meta-introspector/openai-ocaml.git#main

# COPY lib /lang_agent/lib
# COPY bin /lang_agent/bin
# COPY dune-project /lang_agent/
# RUN opam install --yes --deps-only .
# RUN opam install --yes stdio
# RUN dune build .


# # sudo docker build . -t lang_agent
# # sudo docker run -it lang_agent bash

# # dune exec bin/worker.exe
# #  sudo docker  build . -t h4ckermike/lang_agent:dev
FROM ocaml/opam:debian-10-ocaml-4.12
RUN sudo apt install -y libcurl4-gnutls-dev libgmp-dev

WORKDIR /lang_agent/
RUN opam install dune


# sudo docker run -it lang_agent bash 
ENV PATH /home/opam/.opam/4.12/bin/:$PATH
RUN /home/opam/.opam/4.12/bin/dune --version
#RUN apt-get -y install opam


RUN opam repo add coq-released https://coq.inria.fr/opam/released
RUN opam repo add coq-extra-dev https://coq.inria.fr/opam/extra-dev
RUN opam install --yes ppx_yojson_conv_lib coq
RUN opam install --yes ppx_yojson lwt_ppx containers lambdasoup uri ezcurl ppx_yojson_conv ppx_yojson_conv_lib ezcurl-lwt yojson
RUN opam install --yes coq-metacoq-template

COPY lib /lang_agent/lib
COPY bin /lang_agent/bin
COPY dune-project /lang_agent/
RUN opam install --yes --deps-only .
RUN dune build .

# sudo docker build . -t lang_agent
# sudo docker run -it lang_agent bash

# dune exec bin/worker.exe
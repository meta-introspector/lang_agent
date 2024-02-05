FROM ocaml/opam:debian-10-ocaml-4.12
RUN sudo apt install -y libcurl4-gnutls-dev

WORKDIR /lang_agent/
RUN opam install dune

COPY lib /lang_agent/lib
COPY bin /lang_agent/bin
COPY dune-project /lang_agent/

# sudo docker run -it lang_agent bash 
ENV PATH /home/opam/.opam/4.12/bin/:$PATH
RUN /home/opam/.opam/4.12/bin/dune --version
#RUN apt-get -y install opam
RUN opam install --yes --deps-only .
RUN opam install --yes ppx_yojson_conv_lib

RUN opam install --yes ppx_yojson lwt_ppx containers lambdasoup uri ezcurl ppx_yojson_conv ppx_yojson_conv_lib ezcurl-lwt yojson
RUN dune build .

# sudo docker build . -t lang_agent
# sudo docker run -it lang_agent bash

# dune exec bin/worker.exe
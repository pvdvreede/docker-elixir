FROM pvdvreede/dev:latest
USER root
RUN \
  curl -L -O https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
  dpkg -i erlang-solutions_1.0_all.deb && \
  rm -f erlang-solutions_1.0_all.deb
RUN \
  apt-get update -y && \
  apt-get install -y elixir && \
  apt-get clean
RUN \
  mkdir -p /home/dev/.mix/archives && \
  curl -L -o /home/dev/.mix/archives/mix.ez https://s3.amazonaws.com/s3.hex.pm/installs/1.0.0/hex.ez && \
  mix local.rebar --force
RUN git clone --depth=1 https://github.com/elixir-lang/vim-elixir.git /home/dev/.vim/bundle/vim-elixir

# cleanup
RUN chown -R dev:users /home/dev
USER dev

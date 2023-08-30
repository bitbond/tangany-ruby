ARG DISTRO
ARG VERSION

FROM ruby:${VERSION}-${DISTRO}

# Common dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  build-essential \
  curl \
  git \
  gnupg2 \
  less \
  ssh \
  sudo \
  vim \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

# Upgrade rubygems
RUN gem update --system

# Add user sasori
RUN useradd -m -s /bin/bash sasori \
  && usermod -aG sudo sasori \
  && echo "sasori ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Bash config
RUN echo "export HISTFILE=/history/.bash_history" >> /home/sasori/.bashrc \
  && echo 'export PROMPT_COMMAND="history -a"' >> /home/sasori/.bashrc \
  && git clone https://github.com/magicmonty/bash-git-prompt.git /home/sasori/.bash-git-prompt --depth=1 \
  && echo 'if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then GIT_PROMPT_ONLY_IN_REPO=1; source $HOME/.bash-git-prompt/gitprompt.sh; fi' >> /home/sasori/.bashrc \
  && echo 'source /usr/share/bash-completion/completions/git' >> /home/sasori/.bashrc \
  && echo 'export PATH=$PATH:~/bin' >> /home/sasori/.bashrc

# IRB config
RUN echo "require 'irb/ext/save-history'" >> /home/sasori/.irbrc \
  && echo "IRB.conf[:SAVE_HISTORY] = 1000" >> /home/sasori/.irbrc \
  && echo "IRB.conf[:HISTORY_FILE] = \"/history/.irb-history\"" >> /home/sasori/.irbrc

# Volumes & permissions
RUN mkdir -p /history \
  && mkdir -p /home/sasori/.vscode-server \
  && mkdir -p /usr/local/bundle \
  && chown -R sasori:sasori /history \
  && chown -R sasori:sasori /home/sasori/.vscode-server \
  && chown -R sasori:sasori /usr/local/bundle \
  && chown -R sasori:sasori /home/sasori

USER sasori

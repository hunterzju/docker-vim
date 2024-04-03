FROM ubuntu:22.04

# First we need to do a update before installing anything so that apt can find them
RUN apt-get update && \
    # Git is needed for the vim plugin manager
    apt-get -y install git && \
    # The star application
    apt-get -y install vim && \
    # We need curl to easily install the plugin manager
    apt-get -y install curl python3 python3-dev python3-distutils && \
    # plug used
    apt-get -y install clangd ripgrep cargo
# Setup the terminal to use color
ENV TERM=xterm-256color
# Create a user account in the docker container that is based on the account of the executor
# This will be dependent on the docker build command passing in the user_name and user_id that
# the container will be executed as.
ARG user_name
ARG user_id
RUN useradd --uid ${user_id} --shell /bin/bash --create-home --user-group ${user_name}
RUN chpasswd && adduser ${user_name} sudo
USER ${user_name}
WORKDIR /home/${user_name}
RUN chown -R ${user_name} /home/${user_name}
# Install vimrc
# RUN git clone --depth=1 https://gitee.com/hejunwei_669/vimrc.git /home/${user_name}/.vim_runtime  
RUN git clone --depth=1 https://github.com/amix/vimrc.git /home/${user_name}/.vim_runtime  
RUN sh /home/${user_name}/.vim_runtime/install_awesome_vimrc.sh
# Install the plugin manager
# RUN curl -fLo /home/${user_name}/.vim_runtime/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
COPY plug.vim /home/${user_name}/.vim_runtime/autoload/
# Add plugs to use myconfig
RUN echo "call plug#begin('~/.vim_runtime/my_plugins/')\n\
 Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }\n\
 Plug 'airblade/vim-gitgutter'\n\
 Plug 'zivyangll/git-blame.vim'\n\
 Plug 'antiagainst/vim-tablegen'\n\
 Plug 'hunterzju/mlir-vim'\n\
 Plug 'prabirshrestha/vim-lsp'\n\
 Plug 'mattn/vim-lsp-settings'\n\
call plug#end() \n\
if filereadable(".workspace.vim")\n\
    source .workspace.vim\n\
endif" > /home/${user_name}/.vim_runtime/my_configs.vim
# Now configure vim by running the pluging manager and quitting vim
# RUN vim --not-a-term -c "PlugInstall" -c "qa"
# Create a directory to map to external host
VOLUME /home/${user_name}/documents
# Change the working dir
WORKDIR /home/${user_name}/documents
# Start vim
# ENTRYPOINT ["/bin/bash"]

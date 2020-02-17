#!/bin/bash

declare -A dotfiles
dotfiles=(
    ["awesome"]=".config/awesome"
    ["base16-shell"]=".config/base16-shell"
    ["nvim"]=".config/nvim"
    ["bashrc"]=".bashrc"
    ["Xdefaults"]=".Xdefaults"
    ["tmux.conf"]=".tmux.conf"
)

# Packages names differ among distributions
gentoo_packages=("app-editors/neovim" "dev-python/pynvim" "net-libs/nodejs")
arch_packages=("neovim" "python-pynvim" "nodejs" "yarn")
redhat_packages=()

pip_packages=()

main() {
    install_dist_packages

    symlink_dotfiles

    install_neovim_plugins

    print_info "All done."
    print_warn "Please run \"source ~/.bashrc\"."
}

install_neovim_plugins() {
    # Install neovim plugins using vim-plug
    nvim '+PlugInstall | qa'
    # Install Coc basic extensions
    nvim '+CocInstall -sync coc-json coc-yaml coc-sh | qa'

    if [ -x "$(command -v go)" ]; then
        ( cd "${HOME}" && GO111MODULE=on go get golang.org/x/tools/gopls >/dev/null 2>&1 )
        nvim '+CocInstall -sync coc-go | qa'
    fi
    if [ -x "$(command -v python3)" ]; then
        ( cd "${HOME}" && python3 -m pip install --user jedi pylint >/dev/null 2>&1 )
        nvim '+CocInstall -sync coc-python | qa'
    fi
    if [ -x "$(command -v java)" ]; then
        nvim '+CocInstall -sync coc-java | qa'
    fi
}

install_dist_packages() {
    if [ -f "/etc/arch-release" ]; then
        install_arch
    elif [ -f "/etc/gentoo-release" ]; then
        install_gentoo
    elif [ -f "/etc/redhat-release" ]; then
        install_redhat
    else
        print_error_n_exit "Unsupported distribution."
    fi
}

install_arch() {
    for pkg in ${arch_packages[*]}; do
        if ! [ "$(pacman_pkg_installed ${pkg})" = "0" ]; then
            print_info "Installing ${pkg}"
            sudo -p "Enter sudo password: " pacman -S --noconfirm "${pkg}" >/dev/null
        fi
    done
    sudo -k # Next time sudo is run a password will be required
}

install_gentoo() {

    for pkg in ${gentoo_packages[*]}; do
        if ! [ "$(portage_pkg_installed ${pkg})" = "0" ]; then
            print_info "Installing ${pkg}"
            sudo -p "Enter sudo password: " emerge "${pkg}" >/dev/null
        fi
    done
    sudo -k # Next time sudo is run a password will be required
}

install_redhat() {
    # TODO: Implement
    return
}

symlink_dotfiles() {
    [ -d "${HOME}/.config" ] || mkdir "${HOME}/.config"

    for df in ${!dotfiles[@]}; do
        symlink "${PWD}/${df}" "${HOME}/${dotfiles[$df]}"
    done

}

symlink() {
    src=$1
    dest=$2
    # If dotfile already exist, backup it
    #   If it's regular file, remove it
    #   If it's symlink, unlink it

    [ -d "${PWD}/backup" ] || mkdir -p "${PWD}/backup"

    if [ -f "${dest}" ] || [ -d "${dest}" ]; then
        print_info "Dotfile ${dest} exists. Moving to backup dir."
        cp -r "${dest}" "${PWD}/backup/"

        if [ -L "${dest}" ]; then
            unlink "${dest}"
        else
            rm -rf "${dest}"
        fi
    fi

    ln -sf "${src}" "${dest}" >/dev/null 2>&1

    print_info "Dotfile ${src} linked."
}

pacman_pkg_installed() {
    # Check if package is installed
    # Return 0 if installed
    # Return 1 if not installed
    pacman -Qi $1 >/dev/null 2>&1
    echo "$?"
}

portage_pkg_installed() {
    # Check if package is installed
    # Return 0 if installed
    # Return 1 if not installed
    equery list $1 >/dev/null 2>&1
    echo "$?"
}

yum_pkg_installed() {
    # TODO: Implement
    return 1
}

print_info() {
    echo -e "[ INFO  ] $1"
}

print_warn() {
    echo -e "[ \e[33mWARN\e[0m  ] $1"
}

print_error_n_exit() {
    echo -e "[ \e[31mERROR\e[0m ] $1"
    exit 1
}

main "$@"


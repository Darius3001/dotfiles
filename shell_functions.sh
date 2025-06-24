#!/bin/bash

alias lg="lazygit"
alias ld="lazydocker"
alias v="nvim"

function agrep() {
  alias | grep "$*"
}

function w() {
  cd $(walk)
}

alias kg="kubectl get"
alias kd="kubectl describe"

alias kgwf="kubectl get workflowtemplate"
alias kdwf="kubectl describe workflowtemplate"

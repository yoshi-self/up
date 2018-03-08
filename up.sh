#!/bin/bash

## Usage
#
# source up.sh [optioon]
# NOTE: cd doesn't reflect in current shell unless executed by source command
#       setting alias is convenient
# 
## Options
#
#   none      : go up dir once
#   number    : go up dir [number] times
#   word:     : go up to the dir named [word]
#   -g, --git : go up to the root dir of git repo

function go_up_directory() {
  if [ -z $1 ]; then
    # no argument
    cd ..
  elif [[ $1 =~ ^[1-9]+[0-9]* ]]; then
    # with number
    i=0
    while [ $i -lt $1 ]
    do
      cd ..
      i=`expr $i + 1`
    done
  elif [ "$1" = "--git" -o "$1" = "-g" ]; then
    # go to the root dir of git repository
    cd `git rev-parse --show-toplevel`
  else
    # go up dir by name

    # create separated dir names from path
    current_dir=`pwd`
    # remove first /
    dir_names=`echo $current_dir | sed -e 's/^\///'`
    # / to space
    dir_names=`echo $dir_names | sed -e 's/\// /g'`

    # find specified dirname
    dir_num=0 # number of dirs in current path
    last_hit=0 # hierarchy num, from root, of last matched dir
    for name in $dir_names
    do
      dir_num=`expr $dir_num + 1`
      if [ $name = $1 ]; then
        # found
        last_hit=$dir_num
      fi
    done

    if [ $last_hit = 0 ]; then
      # couldn't find the dirname in current path
      echo "up: bad argument"
      exit 0
    fi

    # make path to cd
    i=0;
    dest="/"
    for name in $dir_names
    do
      dest="${dest}${name}/"
      i=`expr $i + 1`
      if [ $i = $last_hit ]; then
        break
      fi
    done

    cd $dest
  fi
}

go_up_directory $1

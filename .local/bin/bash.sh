#!/bin/bash

if [ $(( RANDOM % 2 )) -eq 0 ]; then
    ./.local/bin/themeholder/ssw
else
    exit 0
fi


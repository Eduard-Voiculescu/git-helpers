#!/bin/bash

#/usr/local/bin/git-delete-localonly-branches

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo "not inside git"
        exit 1
fi
for i in $(for i in $(git branch -r); do echo $i |grep origin|grep -v ^HEAD$|sed s@origin/@@  >> /tmp/remotebranches; done
for i in $(git for-each-ref --format='%(refname:short)' refs/heads/); do grep -q ^$i$ /tmp/remotebranches || echo $i    ; done); do echo "delete $i ? (y/n)"; read -s -n1 confirm; [[ $confirm == y ]] && git branch -D $i; done

#!/usr/bin/env zsh

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi

while test $# -gt 0; do
    case "$1" in
        --help)
            exit 0
            ;;
        -l)
            shift
            lc=$1
            shift
            ;;
        *)
            echo "Usage: codelc -l pythonscripts"
            break
            ;;
    esac
done
kernel=$(uname -r)
if [[ "$kernel" = *"microsoft"* ]]; then
    if [[ $lc = *"/"* ]]; then
        echo "" > /dev/null 2>&1
    elif [[ $lc = "." ]]; then
        lc=$PWD/
    else
        lc=$PWD/$lc
    fi
    if [[ $lc = *"/mnt/"* ]]; then
        lc=$(echo $lc | sed -E 's#(\/mnt\/)([a-z])#\2:#g')
        lc=$(echo $lc | sed -E "s#~\/#$HOME\/#g")
        lc=$(echo $lc | sed -E 's/\\/\//g')
        powershell.exe "Invoke-Item '$lc' 2>&1 | Out-Null"
        exit
    else
        lc=$(wslpath -m $lc)
        lc=$(echo $lc | sed -E 's#/#\\#g')
        powershell.exe "Invoke-Item $lc 2>&1 | Out-Null"
        exit
    fi
else
    nlc=$(echo $lc | sed -E "s#~\/#$HOME\/#g")
    open $nlc
    exit
fi
exit

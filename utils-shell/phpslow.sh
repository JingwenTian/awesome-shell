#!/bin/bash

usage() {
    echo "Usage: $0 --log=<LOG>"
}

eval set -- $(
    getopt -q -o "h" -l "context:,log:,help" -- "$@"
)

while true; do
    case "$1" in
        --context) CONTEXT=$2; shift 2;;
        --log)     LOG=$2;     shift 2;;
        -h|--help) usage;      exit 0;;
        --)                    break;;
    esac
done

if [[ -z "$LOG" ]]; then
    usage
    exit 1
fi

C=${CONTEXT:-5}

awk '
    $1 ~ "0x" && $3 ~ "/" { files[$3]++ }
    END {
        for (file in files) {
            print files[file], file | "sort -nr"
        }
    }
' $LOG | while IFS=" " read count data; do
    IFS=":" data=($data)

    file=${data[0]}
    line=${data[1]}

    echo FILE: $file [COUNT: $count]
    cat -n $file | grep -P -C $C --color=always "^\s*$line\t.*"
    echo
done

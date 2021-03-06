#!/bin/bash

## Extension that replaces the builtin [`equals`](#equals) with
## a function that shows the difference as a unified diff
##
## Enable with
##
##     use diff
##
## Requires diff(1).

## ### equals (colordiff)
##
## Test for equality of strings and output unified diff on fail.
##
##     equals <expected> <actual> [<message>]
##
## Example:
##
##     equals "2" 2 "two equals two"
##     equals 2 "$(wc -l my-file)" "two lines in my-file"
##
equals() {
    local expected actual message
    expected="$1"
    actual="$2"
    message="$3"
    message=${message:-(unnamed equals assertion)}
    if [[ "$expected" = "$actual" ]];then
        pass "$message"
    else
        diff=$(diff -U 5 --label expected --label actual <(echo "$expected") <(echo "$actual")|sed 's/^/# /')
        fail "$message\n$diff"
    fi
}

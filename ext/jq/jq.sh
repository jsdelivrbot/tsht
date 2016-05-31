#!/bin/bash

jq_ok() {
    local json_data json_path msg line
    json_path="$1"
    msg="$2"
    json_data=""
    while read line;do
        json_data="$json_data$line"
    done
    actual=$(echo "$json_data" | jq -c "$json_path")
    if [[ "$?" -gt 0 ]];then
        fail "jq error: $msg ($actual)"
    fi
    pass "$msg"
}

jq_equals() {
    local json_data json_path expected msg line
    json_path="$1"
    expected="$2"
    json_data="$3"
    msg="$4"
    if [[ -z "$4" ]];then
        msg="$3"
        json_data=""
        while read line;do
            json_data="$json_data$line"
        done
    fi
    if [[ -z "$msg" ]];then
        msg="JSON: $json_path -> '$expected'"
    fi
    actual="$(echo "$json_data" | jq -c "$json_path")"
    equals "$actual" "$expected" "$msg"
}

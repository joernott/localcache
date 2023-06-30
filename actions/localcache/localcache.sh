#!/bin/bash

function get_archive_name() {
    if [ -z "${key}" ]; then
        echo "::error::key must be provided"
        exit 1
    fi
    archive_name="/tmp/${key}.tar.gz"
}

function generate_archive() {
    if [ -z "${path}" ]; then
        echo "::error::path must not be empty"
        exit 1
    fi
    tar -cpPzf "${archive_name}" ${path}
}

function restore_from_archive() {
    tar -xzf "${archive_name}" ${path}
}

function upload() {
    if [ -z "${cache_url}" ]; then
        echo "::error::cache_url must be provided"
        exit 1
    fi
    if [ -z "${cache_token}" ]; then
        echo "::error::cache_token must be provided"
        exit 1
    fi
    url="${cache_url}/upload?token=${cache_token}"
    RESULT=$(curl -sSf -Ffile=@"${archive_name}" "${url}")
    echo "::notice::Upload result ${RESULT}"
}

function download() {
        if [ -z "${cache_url}" ]; then
        echo "::error::cache_url must be provided"
        exit 1
    fi
    if [ -z "${cache_token}" ]; then
        echo "::error::cache_token must be provided"
        exit 1
    fi
    basename=$(basename "${archive_name}")
    url="${cache_url}/files/${basename}?token=${cache_token}"
    curl -sSf "${url}" -o "${archive_name}"
}

if [ "${restore_keys}" == "" ]; then
    get_archive_name
    generate_archive
    upload
else
    get_archive_name
    download
    restore_from_archive
    rm "${archive_name}"
fi
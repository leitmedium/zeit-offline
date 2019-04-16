#!/bin/bash

has_program() {
    hash $1 2> /dev/null
    return $?
}

get() {
    local url=${1/https:\/\/www/http:\/\/xml}

    if has_program curl; then
        curl -s $url
    elif has_program wget; then
        wget $url --quiet -O -
    else
        echo "Neither curl nor wget found. Aborting."
        usage
        exit 1
    fi
}

convert() {
    xsltproc zeitoffline.xslt -
}

view() {
    local document=$1
    if has_program xxdg-open; then
        xdg-open $document
    elif has_program open; then
        open $document
    else
        echo "Neither xdg-open nor open found. Aborting, as I don't know how to open your browser"
        usage
        exit 1
    fi
}

usage() {
    cat <<EOF
Usage: $0 URL

Converts articles from zeit.de from XML to simple HTML.

Requires either curl or wget for downloading, xslt for conversion and
xdg-open or open for viewing.
EOF
}

make_filename() {
    echo $(mktemp -u ${TMPDIR:-/tmp}/artikel.XXXXXX).html
}

main() {
    local filename=$(make_filename)
    if [ $# -eq 1 ]; then
        get $1 | convert > $filename
        view $filename
    else
        usage
        exit 1
    fi
}

main "$@"

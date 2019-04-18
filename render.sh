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

getImages() {
    grep -Po '(?<=<img src=")(.+?)(?=")' $1 | while read line
    do
        local imageUrl=$(echo "$line" | sed 's/http:\/\/xml/https:\/\/img/g')
        local imageFile=$(mktemp -p $2 "image.XXXXXXX.jpg")
        get $imageUrl > $imageFile
        sed -i "s|$line|file://$imageFile|g" $1

    done

}

convert() {
    xsltproc $1 -
}

view() {
    local document=$1
    if has_program xdg-open; then
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
Usage: $0 [-df] URL

Converts articles from zeit.de from XML to simple HTML.

Requires either curl or wget for downloading, xsltproc for conversion and
xdg-open or open for viewing.

-d : Download images locally

-f : Produce a more fancy version with better styling
EOF
}

make_filename() {
    echo $(mktemp -p $1 "article.XXXXXXX.html")
}

main() {
    local downloadImages=false
    local xsltFile="zeitoffline.xslt"
    if [[ $# -gt 0 ]]; then
        while getopts ":df" opt
        do
            case $opt in
                d)
                    downloadImages=true
                    ;;
                f)
                    xsltFile="zeitoffline-fancy.xslt"
                    ;;
                \?)
                    echo "Invalid option: -$OPTARG" >&2
                    usage
                    exit 1
            esac
        done
        shift $(expr $OPTIND - 1 )
        local folder=$(mktemp -d)
        local filename=$(make_filename $folder)
        get $1 | convert $xsltFile > $filename
        if [[ $downloadImages = true ]]; then
            getImages $filename $folder
        fi
        view $filename
    else
        usage
        exit 1
    fi
}

main "$@"

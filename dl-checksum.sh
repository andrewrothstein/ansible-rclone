#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/rclone/rclone/releases/download
APP=rclone

dl()
{
    local ver=$1
    local lchecksums=$2
    local os=$3
    local arch=$4
    local archive_type=${5:-zip}
    local platform="${os}-${arch}"
    local file="${APP}-v${ver}-${platform}.${archive_type}"
    local url=$MIRROR/v$ver/$file

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(grep $file $lchecksums | awk '{print $1}')
}

dl_ver() {
    local ver=$1
    local lchecksums=$DIR/${APP}-${ver}-SHA256SUMS
    # https://github.com/rclone/rclone/releases/download/v1.66.0/SHA256SUMS
    local rchecksums=$MIRROR/v$ver/SHA256SUMS
    if [ ! -e $lchecksums ];
    then
        curl -sSLf -o $lchecksums $rchecksums
    fi
    printf "  # %s\n" $rchecksums
    printf "  %s:\n" $ver

    dl $ver $lchecksums freebsd 386
    dl $ver $lchecksums freebsd amd64
    dl $ver $lchecksums freebsd arm-v6
    dl $ver $lchecksums freebsd arm-v7
    dl $ver $lchecksums freebsd arm
    dl $ver $lchecksums linux 386
    dl $ver $lchecksums linux amd64
    dl $ver $lchecksums linux arm64
    dl $ver $lchecksums linux arm
    dl $ver $lchecksums linux arm-v6
    dl $ver $lchecksums linux arm-v7
    dl $ver $lchecksums linux mipsle
    dl $ver $lchecksums linux mips
    dl $ver $lchecksums netbsd 386
    dl $ver $lchecksums netbsd amd64
    dl $ver $lchecksums netbsd arm-v6
    dl $ver $lchecksums netbsd arm-v7
    dl $ver $lchecksums netbsd arm
    dl $ver $lchecksums openbsd 386
    dl $ver $lchecksums openbsd amd64
    dl $ver $lchecksums osx amd64
    dl $ver $lchecksums osx arm64
    dl $ver $lchecksums plan9 386
    dl $ver $lchecksums plan9 amd64
    dl $ver $lchecksums solaris amd64
    dl $ver $lchecksums windows 386
    dl $ver $lchecksums windows amd64
    dl $ver $lchecksums windows arm64
}

dl_ver ${1:-1.68.1}

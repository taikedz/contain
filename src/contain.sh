#%include std/safe.sh
#%include std/out.sh
#%include std/askuser.sh


ct:docker() {
    "${CONTAIN_DOCKER_COMMAND:-docker}" "$@"
}


ct:printhelp() {
cat << 'EOHELP'
#%include HELP.md
EOHELP
}


ct:main() {
    if [[ -z "${1:-}" ]]; then
        ct:printhelp
        exit
    fi
    action="$1"
    shift

    case "$action" in
    run)
        ct:create-container "$@" ;;
    build)
        ct:build-image "$@" ;;
    *)
        out:error "Unrecognised parameters."
        ct:printhelp ;;
    esac
}


now() {
    date "+%Y%m%d_%H%M%S"
}


$%function ct:build-image(newname dfpath ?ctxdir) {
    dfpath="$(readlink -f "$dfpath")"
    dfdir="$(dirname "$dfpath")"
    fname="$(basename "$dfpath")"

    if [[ -z "$ctxdir" ]]; then
        ctxdir="$dfdir"
    else
        ln -s "$dfpath" "$ctxdir/$fname"
    fi

    (
    cd "$ctxdir"
    ct:docker build . -f "$fname" -t "$newname" "$@"
    )
    unlink "$ctxdir/$fname"
}

$%function ct:ask(prompt defval) {
    (
    read -e -i "$defval" -p "$prompt : "
    echo "$REPLY"
    )
}

$%function ct:create-container(basename) {
    c_name="interim-from-$(echo $basename|sed 's/[^a-zA-Z0-9_-]/-/g')-$(now)"
    ct:docker run -v "$PWD:/hostdata" --name "$c_name" -it "$basename" "$@"

    if askuser:confirm "Retain as image ? "; then
        new_name="$(ct:ask "Name" "$basename")"

        if ct:docker image inspect "$new_name" >/dev/null 2>&1; then
            dump_name="$new_name-$(now)"
            out:warn "Retagging existing '$new_name' to '$dump_name'"
            ct:docker image tag "$new_name" "$dump_name"
            ct:docker image untag "$dump_name" "$new_name"
        fi

        ct:docker commit "$c_name" "$new_name" || out:fail "Could not commit $c_name as $new_name"
    fi
    ct:docker rm "$c_name"
}


ct:main "$@"

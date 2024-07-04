#%include std/safe.sh
#%include std/out.sh


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
    fi
    action="$1"
    shift

    case "$action" in
    image)
        ct:create-image "$@";;
    use)
        ct:create-container "$@" ;;
    build)
        ct:build-image "$@" ;;
    esac
}



$%function ct:create-image(newname verb basename) {
    [[ "$verb" = from ]] || out:fail "Expectd 'from' instead of '$verb'"

    c_name="interim-$newname-from-$(echo $basename|sed 's/[^a-zA-Z0-9_-]/-/g')-$(date +%Y%m%d_%H%M%S)"

    ct:docker run -it --name "$c_name" "$basename" ${CONTAIN_ENTRYCMD:-bash} || out:fail "Container $c_name exited with error - not comitting"
    ct:docker commit "$c_name" "$newname" || out:fail "Could not commit $c_name as $newname"
    ct:docker rm "$c_name" || out:fail "Could not delete $c_name"
}


ct:main "$@"

bbuild src/contain.sh bin/contain

if [[ "$*" =~ install ]]; then
    cp bin/contain ~/.local/bin/
fi

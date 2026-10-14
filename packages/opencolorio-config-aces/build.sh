gh release download -R "AcademySoftwareFoundation/OpenColorIO-Config-ACES" -p "*.ocio"

for f in ./*.ocio; do
    [ -e "$f" ] || continue

    base=$(basename "$f")
    name="${base%.ocio}"

    # Extract prefix before the first "-v"
    case "$name" in
        *-v*)
            new_name="${name%%-v*}.ocio"
            mv "$f" "./$new_name"
            ;;
    esac
done

mkdir -p "$PREFIX/ocio"
cp -r ./* "$PREFIX/ocio/"
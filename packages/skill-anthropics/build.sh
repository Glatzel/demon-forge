ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
process_skills ./main/skills

for dir in "./knowledge-work-plugins"/*/; do
    [[ -d "$dir" && "${dir##*/}" != .* ]] || continue
    dir_name="${dir%/}" && dir_name="${dir_name##*/}"
    process_skills dir "$PKG_NAME-$dir_name"
done

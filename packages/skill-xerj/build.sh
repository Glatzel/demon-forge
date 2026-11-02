ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
mkdir ./skills
cp -r tools/xerj-code/ ./skills/
process_skills ./skills

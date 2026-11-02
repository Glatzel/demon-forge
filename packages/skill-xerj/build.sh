ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
mkdir ./skills
cp -r tools/xerj-code/ ./skills/
cp -r $RECIPE_DIR/skills/* ./skills/
process_skills ./skills

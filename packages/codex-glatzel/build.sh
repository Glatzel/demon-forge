export CODEX_HOME="$PREFIX"
rtk init -g --codex
cp -r $RECIPE_DIR/config/* "$PREFIX/"

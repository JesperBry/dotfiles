# ---- Git -----
bdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff --style="changes,header"
}
_setup() {
    export PATH="`pwd`/bin:$PATH"
    export REPO=`mktemp --directory`
    git init $REPO
    cd $REPO

    git checkout -b empty
    git commit --allow-empty -m 'init'

    git checkout -b unchanged
    git commit --allow-empty -m 'init2'
    git tag v1.0.0
    git tag somepackage-v1.0.0
    git tag @fancy/package-v1.0.0

    git checkout unchanged
    git checkout -b patch
    git commit --allow-empty -m 'fix: test'

    git checkout unchanged
    git checkout -b minor
    git commit --allow-empty -m 'feat: test'

    git checkout unchanged
    git checkout -b major
    git commit --allow-empty -m 'feat: test
    
BREAKING CHANGE: test'

    git checkout unchanged
    git checkout -b major2
    git commit --allow-empty -m 'feat!: test'
}
_teardown() {
    cd /
    if [ "$REPO" != "" ]; then
        rm -rf "$REPO"
    fi
}
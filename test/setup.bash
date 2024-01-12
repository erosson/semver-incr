_setup() {
    export PATH="`pwd`/bin:$PATH"
    export DIR=`mktemp --directory`
    export REPO="$DIR/repo"
    export REMOTE="$DIR/remote"
    git init $REMOTE
    git init $REPO
    cd $REPO
    git remote add origin "file://$REMOTE"

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

    git checkout unchanged
    git checkout -b monorepo

    mkdir -p a b c d e f
    touch a/file1
    touch b/file1
    touch c/file1
    touch d/file1
    touch e/file1
    touch f/file1
    git add a b c d e f
    git commit -m 'monorepo init'
    git tag a-v1.0.0
    git tag b-v1.0.0
    git tag c-v1.0.0
    git tag f-v1.0.0

    touch a/file2
    git add a
    git commit -m 'fix: monorepo test'

    touch b/file2
    git add b
    git commit -m 'feat: monorepo test'

    touch c/file2
    git add c
    git commit -m 'feat!: monorepo test'

    touch d/file2
    git add d
    git commit -m 'feat!: monorepo test'
    git tag d-v1.0.0
    touch d/file3
    git add d
    git commit -m 'fix: monorepo test'

    touch f/file2
    git add f
    git commit -m 'monorepo test (untagged commit)'
}
_teardown() {
    cd /
    if [ "$REPO" != "" ]; then
        rm -rf "$REPO"
    fi
}
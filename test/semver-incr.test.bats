setup_file() {
    load ./setup
    _setup
}
teardown_file() {
    load ./setup
    _teardown
}
setup() {
    # paths from https://github.com/brokenpip3/devcontainers-bats/blob/main/test/bats-libs/test.sh
    load '/usr/lib/bats/bats-support/load'
    load '/usr/lib/bats/bats-assert/load'
}

EXE=semver-incr
# @test "$EXE: help" {
    # run $EXE --help
    # assert_output --partial Usage:
# }
@test "$EXE: empty" {
    git checkout empty
    run $EXE
    assert_output "v1.0.0"
}
@test "$EXE: unchanged" {
    git checkout unchanged
    run $EXE
    assert_output ""
}
@test "$EXE: patch" {
    git checkout patch
    refute [ $(git tag -l "v1.0.1") ]
    run $EXE
    assert_output "v1.0.1"
    # dry-run by default
    refute [ $(git tag -l "v1.0.1") ]
}
@test "$EXE: minor" {
    git checkout minor
    refute [ $(git tag -l "v1.1.0") ]
    run $EXE
    assert_output "v1.1.0"
    # dry-run by default
    refute [ $(git tag -l "v1.1.0") ]
}
@test "$EXE: major" {
    git checkout major
    refute [ $(git tag -l "v2.0.0") ]
    run $EXE
    assert_output "v2.0.0"
    # dry-run by default
    refute [ $(git tag -l "v2.0.0") ]
}
@test "$EXE: monorepo a" {
    git checkout monorepo
    refute [ $(git tag -l "a-v1.0.1") ]
    run $EXE --prefix a-v --path a
    assert_output "a-v1.0.1"
    # dry-run by default
    refute [ $(git tag -l "a-v1.0.1") ]
}
@test "$EXE: monorepo b" {
    git checkout monorepo
    refute [ $(git tag -l "b-v1.1.0") ]
    run $EXE --prefix b-v --path b
    assert_output "b-v1.1.0"
    # dry-run by default
    refute [ $(git tag -l "b-v1.1.0") ]
}
@test "$EXE: monorepo c" {
    git checkout monorepo
    refute [ $(git tag -l "c-v2.0.0") ]
    run $EXE --prefix c-v --path c
    assert_output "c-v2.0.0"
    # dry-run by default
    refute [ $(git tag -l "c-v2.0.0") ]
}
@test "$EXE: monorepo d" {
    git checkout monorepo
    refute [ $(git tag -l "d-v1.0.1") ]
    run $EXE --prefix d-v --path d
    assert_output "d-v1.0.1"
    # dry-run by default
    refute [ $(git tag -l "d-v1.0.1") ]
}
@test "$EXE: monorepo e" {
    # empty monorepo; one untagged commit (no feat:/fix:). even for untagged commits, always create v1 asap
    git checkout monorepo
    refute [ $(git tag -l "e-v1.0.0") ]
    run $EXE --prefix e-v --path e
    assert_output "e-v1.0.0"
    # dry-run by default
    refute [ $(git tag -l "e-v1.0.0") ]
}
@test "$EXE: monorepo f" {
    git checkout monorepo
    run $EXE --prefix f-v --path f
    assert_output ""
}
@test "$EXE: --execute unchanged" {
    git checkout unchanged
    run $EXE --execute
    assert_output ""
}
@test "$EXE: --execute empty" {
    git checkout empty
    refute [ $(git tag -l "test1-v1.0.0") ]
    refute [ "$(git ls-remote --tags origin "test1-v1.0.0")" != "" ]
    run $EXE --execute --prefix test1-v
    assert_output "test1-v1.0.0"
    # not dry-run this time!
    assert [ $(git tag -l "test1-v1.0.0") ]
    assert [ "$(git ls-remote --tags origin "test1-v1.0.0")" != "" ]
}
@test "$EXE: --execute patch" {
    git checkout patch
    git checkout -b patch2
    refute [ $(git tag -l "v1.0.1") ]
    refute [ "$(git ls-remote --tags origin "v1.0.1")" != "" ]
    run $EXE --execute
    assert_output "v1.0.1"
    # not dry-run this time!
    assert [ $(git tag -l "v1.0.1") ]
    assert [ "$(git ls-remote --tags origin "v1.0.1")" != "" ]
}
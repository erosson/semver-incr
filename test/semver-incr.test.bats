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
    run $EXE
    assert_output "v1.0.1"
}
@test "$EXE: minor" {
    git checkout minor
    run $EXE
    assert_output "v1.1.0"
}
@test "$EXE: major" {
    git checkout major
    run $EXE
    assert_output "v2.0.0"
}
@test "$EXE: monorepo a" {
    git checkout monorepo
    run $EXE --prefix a-v --path a
    assert_output "a-v1.0.1"
}
@test "$EXE: monorepo b" {
    git checkout monorepo
    run $EXE --prefix b-v --path b
    assert_output "b-v1.1.0"
}
@test "$EXE: monorepo c" {
    git checkout monorepo
    run $EXE --prefix c-v --path c
    assert_output "c-v2.0.0"
}
@test "$EXE: monorepo d" {
    git checkout monorepo
    run $EXE --prefix d-v --path d
    assert_output "d-v1.0.1"
}
@test "$EXE: monorepo e" {
    # empty monorepo; one untagged commit (no feat:/fix:). even for untagged commits, always create v1 asap
    git checkout monorepo
    run $EXE --prefix e-v --path e
    assert_output "e-v1.0.0"
}
@test "$EXE: monorepo f" {
    git checkout monorepo
    run $EXE --prefix f-v --path f
    assert_output ""
}
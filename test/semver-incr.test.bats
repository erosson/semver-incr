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
    assert_output "1.0.0"
}
@test "$EXE: unchanged" {
    git checkout unchanged
    run $EXE
    assert_output ""
}
@test "$EXE: patch" {
    git checkout patch
    run $EXE
    assert_output "1.0.1"
}
@test "$EXE: minor" {
    git checkout minor
    run $EXE
    assert_output "1.1.0"
}
@test "$EXE: major" {
    git checkout major
    run $EXE
    assert_output "2.0.0"
}
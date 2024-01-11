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

EXE=_current-semver
@test "help" {
    run $EXE --help
    assert_output --partial Usage:
}
@test "$EXE: empty" {
    git checkout empty
    run $EXE
    assert_output ""
}
@test "$EXE: unchanged" {
    git checkout unchanged
    run $EXE
    assert_output "v1.0.0"
}
@test "$EXE: prefix match" {
    git checkout unchanged
    run $EXE --prefix somepackage-v
    assert_output "somepackage-v1.0.0"
}
@test "$EXE: fancy prefix match" {
    git checkout unchanged
    run $EXE --prefix @fancy/package-v
    assert_output "@fancy/package-v1.0.0"
}
@test "$EXE: prefix mismatch" {
    git checkout unchanged
    run $EXE --prefix nopackage-v
    assert_output ""
}

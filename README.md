# semver-incr-git

Automates [semantic versioning](https://semver.org/) git tagging. Write [conventional commit messages](https://github.com/angular/angular/blob/main/CONTRIBUTING.md#-commit-message-format) for your project, run `semver-incr` (preferably from CI), and receive a git tag based on your commits.

Designed for continuous integration. Works for both monorepos and multirepos. Depends only on git and bash. Not tied to any particular language or toolset.

If `semver-incr` doesn't quite fit your needs, this package also provides the smaller scripts `semver-incr` is built with, so you can build and fine-tune your own automatic versioning system. (TODO: Not yet documented, read the source)

## Usage

In your commit messages, write `fix:`, `feat:`, or `feat!:`/`BREAKING CHANGE:` to indicate patch, minor, and major version changes respectively.

For most repositories, this prints a suggested version number based on your commit messages:

```console
$ semver-incr-git
v1.2.3
$ git show v1.2.3
fatal: Failed to resolve 'v1.2.3' as a valid ref.
```

By default, this is a dry-run - nothing changes. If things look right, commit and push the new tag:

```console
$ semver-incr-git --execute
v1.2.3
$ git show v1.2.3
commit abc123...
```

If you're in a monorepo and want to release each package separately, prefix its git tags and filter for its directory:

```console
$ semver-incr-git --path ./packages/my-package --prefix @company/my-package/v #[--execute]
@company/my-package/v1.2.3
```

## CHANGELOG files

This project doesn't generate them. I write changelog files by hand, or for small personal projects I don't write them (shame on me).

TODO: recommend a tool

## Related work

The most notable automated semantic versioning tools I tried:

* https://github.com/semantic-release/semantic-release (widely used, monorepos not supported, monorepo extensions I tried were all broken, tied to node)
* https://github.com/changesets/changesets (less automated than semantic-release, but arguably better for teams, and good for CHANGELOG files)
* https://github.com/microsoft/beachball

There's a lot of them out there!

I use this in [`semver-incr-npm`](https://github.com/erosson/ts-libs/tree/main/packages/semver-incr).

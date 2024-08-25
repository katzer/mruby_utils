## Release Notes: _mruby_utils_

### 3.2.0 (25.08.2022)

- Fix compatibility with mruby v3.2.0

### 3.1.0 (05.07.2022)

- Fix running in docker detection.
- Fix compatibility with mruby v3.1.0

### 3.0.4 (05.07.2022)

- Fix github repo clone uri.

### 3.0.1 (09.05.2021)

- Fix `sshd` task did not start agent.

### 3.0.0 (09.03.2021)

- Added support mruby v3.
- Dropped support for mruby v2.
- Fixed `version` task to be non-verbose.
- Updated `dockerize` task to generate a v3.9 compose file.

### 1.4.5 (18.02.2020)

- Fix `mruby:strip` did not recognice MacOS deplyoment target.

### 1.4.4 (09.08.2019)

- Fixed `update:mgems` task.

### 1.4.3 (07.08.2019)

- Fixed run `rake test:mtest` from `MRUBY_ROOT`.
- Added more logging in verbose mode.

### 1.4.2 (07.08.2019)

- Changed default value of `$MRUBY_VERSION` to `"stable"`.
- Changed default value of `$MRUBY_BUILD_DIR` to `"build"`.

### 1.4.1 (26.07.2019)

- Fixed issue with `source:` parameter.

### 1.4.0 (26.07.2019)

- Added `source:` parameter to `configure_libssh2()`.

### 1.3.0 (03.07.2019)

- Added `debug:` parameter to `configure_libssh2()`.

### 1.2.0 (14.06.2019)

Initial version by extracting existing code into a ruby gem.
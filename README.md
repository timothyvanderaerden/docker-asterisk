# docker-asterisk

A set of Docker files with Asterisk LTS. A fixed release is used since Alpine could break in between releases, you can find the version inside `shared/download.sh`. These are very basic images and not optimized for production. You can add or remove modules with `menuselect`, this can be configured in `shared/menuselect.sh`. The following baseImages are available:

- Alpine (latest)
- CentOS (latest)
- Debian (latest)
- Fedora (latest)
- Ubuntu (latest)

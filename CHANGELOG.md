The headline features of Hare 0.25.2 are

- Buffered I/O improvements
- Documentation tooling improvements
- Expanded Unix API coverage
- Integration of third-party tools into hare(1)
- Mandatory error handling in out-of-memory conditions (nomem)
- Revised and improved APIs for time/date support
- Semantic code annotations
- Tooling for updating codebases affected by breaking changes
- Buffered I/O improvements

The bufio:: and memio:: modules have landed numerous improvements in this release cycle, including:

- Options to fine-tune the behavior of bufio::scanner
- A “nonblocking” mode for memio:: streams
- Managed bufio::stream modes
- os::open_buffered and os::create_buffered
- io::seek support for bufio::scanner

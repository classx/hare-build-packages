FROM ubuntu:22.04 as BUILDER
ADD hare /src/hare
ADD harec /src/harec
ADD qbe /src/qbe
ADD scdoc /src/scdoc

RUN apt-get update && apt-get install -y build-essential
RUN cd /src/qbe && make && make install
RUN cd /src/harec && make && make install
RUN cd /src/scdoc && make && make install
RUN cd /src/hare && make && make install

FROM goreleaser/nfpm as PACKAGER
COPY --from=BUILDER /usr/local/bin/hare /usr/local/bin/hare
COPY --from=BUILDER /usr/local/bin/harec /usr/local/bin/harec
COPY --from=BUILDER /usr/local/bin/haredoc /usr/local/bin/haredoc
COPY --from=BUILDER /usr/local/bin/scdoc /usr/local/bin/scdoc
COPY --from=BUILDER /usr/local/bin/qbe /usr/local/bin/qbe
COPY --from=BUILDER /usr/local/share/man/man1/scdoc.1 /usr/local/share/man/man1/scdoc.1
COPY --from=BUILDER /usr/local/share/man/man5/scdoc.5 /usr/local/share/man/man5/scdoc.5
COPY --from=BUILDER /usr/local/share/pkgconfig/scdoc.pc /usr/local/share/pkgconfig/scdoc.pc

COPY --from=BUILDER /usr/local/share/man/man1/hare.1 /usr/local/share/man/man1/hare.1
COPY --from=BUILDER /usr/local/share/man/man1/hare-build.1 /usr/local/share/man/man1/hare-build.1
COPY --from=BUILDER /usr/local/share/man/man1/hare-cache.1 /usr/local/share/man/man1/hare-cache.1
COPY --from=BUILDER /usr/local/share/man/man1/hare-deps.1 /usr/local/share/man/man1/hare-deps.1
COPY --from=BUILDER /usr/local/share/man/man1/haredoc.1 /usr/local/share/man/man1/haredoc.1
COPY --from=BUILDER /usr/local/share/man/man1/hare-run.1 /usr/local/share/man/man1/hare-run.1
COPY --from=BUILDER /usr/local/share/man/man1/hare-test.1 /usr/local/share/man/man1/hare-test.1
COPY --from=BUILDER /usr/local/share/man/man5/haredoc.5 /usr/local/share/man/man5/haredoc.5
COPY --from=BUILDER /usr/local/share/man/man5/hare-module.5 /usr/local/share/man/man5/hare-module.5

COPY --from=BUILDER /usr/local/src/hare/stdlib /usr/local/src/hare/stdlib
ADD package.yml /src/package.yml

WORKDIR /src

RUN nfpm pkg --config package.yml --target /src --packager deb

FROM ubuntu:22.04 as VIEW
COPY --from=PACKAGER /src/*.deb /src/





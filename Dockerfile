FROM rustlang/rust:nightly as local
WORKDIR /image-png
COPY . .
RUN cargo install cargo-fuzz
RUN cargo fuzz run decode -- -runs=0

FROM gcr.io/oss-fuzz-base/base-builder-rust as builder
RUN apt-get update && apt-get install -y make autoconf automake libtool curl cmake python llvm-dev libclang-dev clang
COPY . $SRC/image-png
WORKDIR $SRC
COPY build.sh $SRC/
ENV FUZZING_LANGUAGE=rust
RUN compile

FROM gcr.io/oss-fuzz-base/base-runner as runner
COPY --from=builder /out /targets
CMD ["/targets/decode"]

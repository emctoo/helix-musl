FROM rust:alpine as builder

ARG VERSION='22.05'

RUN apk add --update --no-cache bash git gcc build-base musl-dev rustup && rm -rf /var/cache/apk/*

RUN \
  git clone --recurse-submodules --shallow-submodules -j8 --depth=1 -b $VERSION https://github.com/helix-editor/helix && \
  cd helix && \
  rustup update && \
  cargo install --path helix-term && \
  hx --grammar fetch && \
  hx --grammar build

FROM alpine:3.16.0

ARG VERSION='22.05'

WORKDIR "/helix"
ENV PATH=/helix:"$PATH"

# default is $HOME/.config/helix/runtime
ENV HELIX_RUNTIME=/helix/runtime  

COPY --from=builder /root/.cargo/bin/hx /helix/hx
COPY --from=builder /helix/runtime /helix/runtime

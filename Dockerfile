FROM rust:latest as build

WORKDIR /app
COPY Cargo.toml /app/Cargo.toml
COPY Cargo.lock /app/Cargo.lock

RUN mkdir src && touch src/main.rs
RUN cargo fetch --locked

COPY src /app/src

RUN cargo build --verbose --locked
RUN cargo test --verbose

FROM fedora:latest

ENV RUST_LOG=info
WORKDIR /server

COPY --from=build /app/target/debug/octo-sports-api /server/runner

EXPOSE 8080
CMD [ "/server/runner" ]

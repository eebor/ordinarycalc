FROM alpine:latest AS build

RUN apk update
RUN apk add nasm
RUN apk add gcc
RUN apk add make

ARG BITRATE=32

WORKDIR /prog
COPY . .

RUN make build${BITRATE}

FROM scratch AS prod

ARG BUILD_SRC=""

COPY --from=build "/prog/${BUILD_SRC}" "prog"

ENTRYPOINT [ "./prog" ]


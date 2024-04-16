FROM ubuntu AS base
RUN apt-get -y update && apt-get -y install git make byacc gcc vim

FROM base AS miranda
RUN git clone https://github.com/domanteli0/miranda.git

WORKDIR /miranda

RUN make cleanup
RUN make
RUN make install

FROM miranda AS src

WORKDIR /

COPY /ex /ex


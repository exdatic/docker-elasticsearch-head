FROM alpine as es-head

WORKDIR /
RUN apk add --no-cache wget unzip
RUN wget https://github.com/mobz/elasticsearch-head/archive/master.zip && \
    unzip master.zip                                                   && \
    cd elasticsearch-head-master                                       && \
    sed -i "s|base_uri: null|base_uri: window.location.origin + '/es/'|g" _site/app.js

FROM flashspys/nginx-static
COPY --from=es-head /elasticsearch-head-master /static

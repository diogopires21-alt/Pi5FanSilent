FROM homeassistant/aarch64-base:latest
COPY run.sh /run.sh
RUN chmod +x /run.sh
RUN printf '#!/bin/sh\nexec /run.sh\n' > /init && chmod +x /init

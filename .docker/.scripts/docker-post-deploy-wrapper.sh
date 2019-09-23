#!/bin/bash
set -eu
# ----------------------------------------------------------------------------------------------------------------------

# THIS IS CALLED FROM ENTRYPOINT.

# Load .env and .env.<APP_ENV> into script (won't overwrite OS env vars.)
set -a
    env_overwrite=./.env.${APP_ENV-dev}
    declare -px >> /tmp/envsrc && . ./.env && if [ -f ${env_overwrite} ]; then . $env_overwrite; fi && . /tmp/envsrc \
     && rm /tmp/envsrc && unset env_overwrite
set +a

# Run Post Deployment Custom Script (post-deployment.sh)
docker-post-deployment
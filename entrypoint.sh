#!/bin/bash

set -e

## Get the local IPv4
export GREMLIN_IDENTIFIER=$(curl -s --connect-timeout 3 169.254.169.254/latest/meta-data/local-ipv4)

if test $# -eq 0; then
    gremlin version || true
    gremlind version || true
    exec /bin/bash
fi

cmd="$1"

_current_date="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
_credentials_expires_at="$(grep expires_at /var/lib/gremlin/.credentials 2>/dev/null | cut -d: -f2-)"
# If credentials do not already exist, and the environment variables are set, then run init before running any non-logout command
if  (test ! -f /var/lib/gremlin/.credentials || test "$_credentials_expires_at" \< "$_current_date") && \
	(test "$GREMLIN_ORG_ID" != "" || test "$GREMLIN_TEAM_ID" != "") && \
	(test "$GREMLIN_ORG_SECRET" != "" || test "$GREMLIN_TEAM_SECRET" != "") && \
	test "$cmd" != "logout"; then
    gremlin init
fi

if test "$cmd" = "daemon"; then
    shift
    exec gremlind "$@"
fi

exec gremlin "$@"

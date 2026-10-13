#!/bin/bash
if [ -n "$DOKKU_POSTGRES_AQUA_URL" ]; then
DATABASE_URL="$DOKKU_POSTGRES_AQUA_URL"
fi

export KC_DB_PASSWORD=$(echo "$DATABASE_URL" | cut --delimiter=: -f3 | cut --delimiter=\@ -f1)

export KC_DB_URL=jdbc:postgresql://$(echo "$DATABASE_URL" | cut --delimiter=\@ -f2)

export KC_DB_USERNAME=postgres

"$1"
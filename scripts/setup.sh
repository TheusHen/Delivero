#!/bin/bash
# Creates bucket and tests MinIO connection
set -e

echo "Configuring MinIO..."

MC_ALIAS="${MC_ALIAS:-myminio}"
MC_ENDPOINT="${MINIO_ENDPOINT:-http://localhost:9000}"
MC_ACCESS_KEY="${MINIO_ACCESS_KEY:-minioadmin}"
MC_SECRET_KEY="${MINIO_SECRET_KEY:-minioadmin}"
MC_BUCKET="${MINIO_BUCKET:-delivero}"

mc alias set "$MC_ALIAS" "$MC_ENDPOINT" "$MC_ACCESS_KEY" "$MC_SECRET_KEY"
mc mb --ignore-existing "${MC_ALIAS}/${MC_BUCKET}"

echo "Bucket ${MC_BUCKET} ready at ${MC_ENDPOINT}"
mc ls "${MC_ALIAS}/${MC_BUCKET}"

#!/usr/bin/env sh
docker-compose down

./scripts/fix-rights.sh

docker-compose up -d
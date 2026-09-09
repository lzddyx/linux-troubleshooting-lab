#!/bin/bash

mkdir -p logs

cat > logs/app.log <<'EOF'
2026-09-09 10:00:01 INFO Application starting
2026-09-09 10:00:02 INFO Loading configuration
2026-09-09 10:00:03 INFO Connecting to database
2026-09-09 10:00:04 WARN Database connection slow
2026-09-09 10:00:05 INFO Retrying database connection
2026-09-09 10:00:06 INFO Database connected
2026-09-09 10:00:07 INFO Starting API server
2026-09-09 10:00:08 ERROR Failed to bind to port 8080: Address already in use
2026-09-09 10:00:09 INFO Retrying server startup
2026-09-09 10:00:10 ERROR Application startup failed
EOF

echo "Log troubleshooting lab created."

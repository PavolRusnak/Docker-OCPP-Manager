FROM alpine:3.20

# Install dependencies and tools
RUN apk --no-cache add \
    ca-certificates \
    tzdata \
    curl \
    wget \
    && rm -rf /var/cache/apk/*

# Create app user and directories
RUN adduser -D app && mkdir -p /app /data && chown -R app:app /app /data

# Set working directory
WORKDIR /app

# Copy built application
COPY build/ /app/

# Copy React frontend files
COPY web/dist/ /app/

# Set environment variables
ENV HTTP_ADDR=:9999 \
    WS_LISTEN_PATH=/ocpp \
    METER_DATA_DIR=/data/meter_data \
    ACTIVITY_LOG_DIR=/data/activity_logs \
    REPORT_DIR=/data/reports \
    CARDS_DIR=/data/cards \
    EVENTS_DIR=/data/events \
    TIMEZONE=America/Vancouver \
    POLL_MINUTES=15 \
    HEARTBEAT_SEC=60 \
    MAX_SENDLOCAL_BATCH=10 \
    ENABLE_HOURLY_REFRESH=true \
    METER_RETRY_MINUTES=5 \
    POLL_INTERVAL_SECONDS=900 \
    CSV_DIR=/data/meter \
    TRIGGER_TIMEOUT_MS=10000 \
    TRIGGER_RETRY=1 \
    ENABLE_CLOCK_ALIGNED=1

# Expose port
EXPOSE 9999

# Switch to app user
USER app

# Set entrypoint
ENTRYPOINT ["/app/ocpp-power-manager"]


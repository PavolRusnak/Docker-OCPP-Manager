# Docker OCPP Manager

A Dockerized OCPP 1.6J management server for EV charging stations with CSV-based storage.

## 🚀 Quick Start

### Prerequisites
- Docker and Docker Compose
- No other dependencies required

### Running the Application

1. Clone this repository:
   ```bash
   git clone https://github.com/PavolRusnak/Docker-OCPP-Manager.git
   cd Docker-OCPP-Manager
   ```

2. Start the application:
   ```bash
   docker-compose up -d
   ```

3. Open your browser to `http://localhost:9999`

**That's it!** The application runs with:
- ✅ **CSV-based storage** - All data in `/data` directory
- ✅ **OCPP WebSocket server** - Available at `ws://localhost:9999/ocpp/{station_id}`
- ✅ **Web interface** - Full management dashboard
- ✅ **Automatic data collection** - Meter readings every 15 minutes
- ✅ **Total energy polling** - Cumulative energy register tracking every 15 minutes

## 📋 Features

- **OCPP 1.6J WebSocket Server** - Full OCPP protocol support
- **CSV-Only Storage** - No database required, all data stored in CSV files
- **Real-time Monitoring** - Live station status and energy tracking
- **RFID Card Management** - Authorize and manage charging cards
- **Meter Data Collection** - Automatic energy usage tracking
- **15-Minute Total Energy Polling** - Reliable cumulative energy register tracking
- **Docker Ready** - Single container deployment

## ⚙️ Configuration

The application uses environment variables for configuration. Copy `env.example` to `.env` and modify as needed:

```bash
HTTP_ADDR=:9999                    # Server address
WS_LISTEN_PATH=/ocpp               # WebSocket path
METER_DATA_DIR=/data/meter_data    # Meter data storage
CARDS_DIR=/data/cards              # RFID cards storage
EVENTS_DIR=/data/events            # Event logs storage
TIMEZONE=America/Vancouver         # Timezone for data
POLL_MINUTES=15                    # Meter polling interval
HEARTBEAT_SEC=60                   # Station heartbeat interval
MAX_SENDLOCAL_BATCH=10             # RFID batch size
METER_RETRY_MINUTES=5              # Meter retry interval

# 15-minute total energy polling settings
POLL_INTERVAL_SECONDS=900          # Energy polling interval (15 minutes)
CSV_DIR=./data/meter               # Energy CSV storage directory
TRIGGER_TIMEOUT_MS=10000           # TriggerMessage timeout
TRIGGER_RETRY=1                    # Number of retries for failed polls
ENABLE_CLOCK_ALIGNED=1             # Enable ClockAlignedData configuration
```

## 📊 Data Storage

All data is stored in CSV files within the `/data` directory:

- **Cards**: `/data/cards/cards.csv` - RFID authorization cards
- **Meter Data**: `/data/meter_data/{YYYY-MM-DD}/` - Daily energy readings
- **Total Energy**: `/data/meter/{YYYY-MM-DD}/{stationId}.csv` - 15-minute cumulative energy readings
- **Events**: `/data/events/{YYYY}/{MM}/{YYYY-MM-DD}.csv` - System events
- **Stations**: `/data/stations/stations.csv` - Charging station registry

## 🔌 OCPP Integration

Stations connect to the WebSocket endpoint:
```
ws://<server-ip>:9999/ocpp/{station_id}
```

The server supports:
- **Authorization** - RFID card validation
- **Meter Values** - Energy usage tracking
- **Heartbeat** - Station presence monitoring
- **Local List Management** - RFID card synchronization
- **Total Energy Polling** - Automatic cumulative energy register tracking

## 🛠️ Management Commands

```bash
# View logs
docker-compose logs -f

# Stop the application
docker-compose down

# Restart the application
docker-compose restart

# Check status
docker-compose ps

# Rebuild and restart
docker-compose up -d --build
```

## 📡 API Endpoints

- `GET /api/stations` - List charging stations
- `GET /api/cards` - List RFID cards
- `POST /api/cards/sync` - Sync cards with stations
- `GET /api/events` - List system events
- `GET /api/settings` - Get system settings
- `POST /api/settings/server/start` - Start OCPP server
- `POST /api/settings/server/stop` - Stop OCPP server
- `GET /api/energy/stations/:id/energy` - Get latest energy data for a station
- `POST /api/energy/admin/poll-now` - Trigger immediate energy poll

## 🔧 Development

### Building Locally

```bash
# Build Docker image
docker build -t docker-ocpp-manager .

# Run with custom configuration
docker run -d \
  --name ocpp-manager \
  -p 9999:9999 \
  -v $(pwd)/data:/data \
  docker-ocpp-manager
```

### Using Docker Compose

```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Rebuild and start
docker-compose up -d --build
```

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📞 Support

For support and questions, please open an issue in the GitHub repository.

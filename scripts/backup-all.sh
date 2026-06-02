#!/bin/bash

set -e

PROJECT_DIR="/var/www/wordpress"
BACKUP_DIR="$PROJECT_DIR/data/backup"
LOG_DIR="$PROJECT_DIR/logs/backup"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

DB_CONTAINER="wp_database"
DB_NAME="${MYSQL_DATABASE}"
DB_USER="${MYSQL_USER}"
DB_PASSWORD="${MYSQL_PASSWORD}"

mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_DIR"

echo "[$DATE] Starting WordPress backup..." >> "$LOG_DIR/backup.log"

cd "$PROJECT_DIR"

# Load environment variables
set -a
source "$PROJECT_DIR/.env"
set +a

# Backup database
docker exec "$DB_CONTAINER" mariadb-dump -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" > "$BACKUP_DIR/db-$DATE.sql"

tar -czf "$BACKUP_DIR/db-$DATE.sql.tar.gz" -C "$BACKUP_DIR" "db-$DATE.sql"
rm "$BACKUP_DIR/db-$DATE.sql"

# Backup wp-content / wordpress files
tar -czf "$BACKUP_DIR/wordpress-files-$DATE.tar.gz" -C "$PROJECT_DIR/data" wordpress

# Backup compose and configs, without .env
tar -czf "$BACKUP_DIR/config-$DATE.tar.gz" \
  docker-compose.yml \
  .gitignore \
  php-fpm \
  nginx \
  scripts

# Delete backup older than 7 days
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +7 -delete

echo "[$DATE] Backup completed successfully." >> "$LOG_DIR/backup.log"

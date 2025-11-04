#!/bin/bash
# Linux-compatible rollback script for NGINX deployment

DEPLOY_DIR="/var/www/html/stellartrack"
BACKUP_DIR="/var/www/html/stellartrack_backup"

echo "🔁 Starting rollback process..."

if [ -d "$BACKUP_DIR" ]; then
    sudo rm -rf "$DEPLOY_DIR"
    sudo cp -r "$BACKUP_DIR" "$DEPLOY_DIR"
    echo "✅ Rollback complete!"
else
    echo "❌ No backup found for rollback."
fi

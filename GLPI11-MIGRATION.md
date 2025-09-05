# GLPI 11 Migration Guide

This document provides instructions for updating your GLPI container deployment to use GLPI 11.

## Before You Start

1. **Backup your data**: Always backup your GLPI database and files before upgrading
2. **Check GLPI 11 availability**: Verify that GLPI 11 releases are available at https://github.com/glpi-project/glpi/releases
3. **Review GLPI 11 changes**: Check the GLPI 11 changelog for any breaking changes

## Quick Update Steps

### 1. Update Configuration Files

Update your `.env` file to use the desired GLPI 11 version:
```bash
# Change this line in your .env file
VERSION="11.0.0"
```

### 2. Rebuild the Docker Image

If using docker-compose-build.yml:
```bash
docker compose -f docker-compose-build.yml build --no-cache
```

If building manually:
```bash
docker build --build-arg VERSION=11.0.0 php/
```

### 3. Update and Restart Services

```bash
# Pull the latest pre-built image (if available)
docker compose pull

# Restart all services
docker compose down
docker compose up -d
```

## Testing Different GLPI 11 Versions

You can test different GLPI 11 versions by specifying the version:

```bash
# Test with a specific version
docker build --build-arg VERSION=11.0.1 php/

# Or update your .env file and rebuild
VERSION="11.0.1" docker compose -f docker-compose-build.yml build
```

## Troubleshooting

### Version Not Found Error
If you get a "404 Not Found" error during build, the GLPI version you specified might not exist. Check available versions at:
https://github.com/glpi-project/glpi/releases

### Database Migration Issues
GLPI will automatically handle database migrations when you start the container. Monitor the logs for any migration errors:
```bash
docker compose logs glpi-db-install
docker compose logs php
```

### Pre-release Versions
For pre-release versions (alpha, beta, RC), make sure to:
1. Use the exact version string from GitHub releases
2. Enable pre-release support in the GitHub workflow if using automated builds

## Rollback Plan

If you need to rollback to GLPI 10:

1. Update your `.env` file:
   ```bash
   VERSION="10.0.17"
   ```

2. Rebuild and restart:
   ```bash
   docker compose -f docker-compose-build.yml build --no-cache
   docker compose down
   docker compose up -d
   ```

3. Restore your database backup if necessary

## Getting Help

- GLPI Documentation: https://glpi-project.org/documentation/
- GLPI Community: https://github.com/glpi-project/glpi/discussions
- Container Issues: https://github.com/sysadminsmedia/franken-glpi/issues
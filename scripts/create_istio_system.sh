#!/bin/bash
istioctl version
istioctl install -f /app/config.yaml
istioctl verify-install -f /app/config.yaml
#!/bin/bash
istioctl version
istioctl install --set revision=$revisionName -f /app/config.yaml
istioctl verify-install --revision $revisionName
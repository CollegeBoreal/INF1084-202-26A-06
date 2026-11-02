#!/usr/bin/env pwsh
# --------------------------------------
# Dynamic Participation Generator
# --------------------------------------

# Load students + compute groups
. ../.scripts/students.ps1

pwsh .scripts/participation.ps1 > .scripts/Participation.md 2>$null


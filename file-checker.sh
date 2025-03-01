#!/bin/bash

# List of expected files
files=(
  "build-image-test.yaml"
  "build-image.yaml"
  "ci-cd.yml"
  "codeql.yml"
  "dependency-review.yml"
  "pr-title.yml"
  "pre-commit.yaml"
  "release.yml"
  "reusable-tox.yml"
  "scheduled-runs.yml"
  "scorecards.yml"
  "stale-actions.yaml"
)

# Flag to track missing files
missing_flag=0

# Check for each file
for file in "${files[@]}"; do
  if [[ ! -e "$file" ]]; then
    echo "Missing: $file"
    missing_flag=1
  fi
done

# Final message
if [[ $missing_flag -eq 1 ]]; then
  echo "Some files are missing."
else
  echo "All files are present."
fi

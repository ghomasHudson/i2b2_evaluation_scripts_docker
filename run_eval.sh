#!/bin/sh

# Usage:
#   ./run_eval.sh <path_to_gold_file> <path_to_pred_file>
# Example:
#   ./run_eval.sh ./data/gold.txt ./data/pred.txt

# Validate arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path_to_gold_file> <path_to_pred_file>"
    exit 1
fi

GOLD_PATH=$1
PRED_PATH=$2

# Ensure paths are absolute to avoid Docker volume issues
GOLD_ABS=$(realpath "$GOLD_PATH")
PRED_ABS=$(realpath "$PRED_PATH")

# Extract directory paths
GOLD_DIR=$(dirname "$GOLD_ABS")
PRED_DIR=$(dirname "$PRED_ABS")

IS_DIR=$(test -d "$GOLD_ABS" && echo "yes" || echo "no")

GOLD_ABS=$(basename "$GOLD_ABS")
PRED_ABS=$(basename "$PRED_ABS")

if [ "$IS_DIR" = "yes" ]; then
    # Add trailing slash for directories
    GOLD_ABS="${GOLD_ABS}/"
    PRED_ABS="${PRED_ABS}/"
fi

# Run Docker
docker run --rm \
    -v "$GOLD_DIR":/gold \
    -v "$PRED_DIR":/pred \
    i2b2-eval phi -v "/gold/$GOLD_ABS" "/pred/$PRED_ABS"


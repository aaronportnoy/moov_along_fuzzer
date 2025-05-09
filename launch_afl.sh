#!/usr/bin/env bash
set -euo pipefail

# Shell script to launch AFL++

export AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1
export AFL_SKIP_CPUFREQ=1
export AFL_MAP_SIZE=131072
export ASAN_OPTIONS="alloc_dealloc_mismatch=0:abort_on_error=1:symbolize=0"
export AFL_USE_ASAN=0
export AFL_NO_AFFINITY=1
export MALLOC_CHECK_=0
export MALLOC_PERTURB_=0

# Paths (customize if needed)
SEEDS="fuzz/in"
OUTDIR="fuzz/out"
WRAPPER="moov_along/build/fastmp4"
TIMEOUT=5000
#DICT="fuzz/dict.txt"

# Clean and prepare output directory
rm -rf "$OUTDIR"
mkdir -p "$OUTDIR"

# Launch afl
echo "Starting AFL++ master..."
afl-fuzz -t "$TIMEOUT" -i "$SEEDS" -o "$OUTDIR" -- "$WRAPPER" @@ &

# Give master a moment to initialize the session directory
sleep 1

# Wait for fuzzer to exit
wait

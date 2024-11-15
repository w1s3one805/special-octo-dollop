#!/bin/bash

# Copyright 2024 The ChromiumOS Authors
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

TARGET_DIR="$1"
SHARED_LIB="$2"
VERSION="$3"
BUILDTYPE="$4"
CARGO_RELEASE="$5"

SHARED_LIB_FULL="$SHARED_LIB"".$VERSION"
SHARED_LIB_MAJOR="$SHARED_LIB"".0"

# The following returns true if $CARGO_RELASE is the empty string
if [[ -z "$CARGO_RELEASE" ]]
then
  CARGO_TARGET_DIR="$TARGET_DIR" cargo build --features="$FEATURES" --target-dir="$TARGET_DIR"
else
  CARGO_TARGET_DIR="$TARGET_DIR" cargo build --features="$FEATURES" --target-dir="$TARGET_DIR" --release
fi

CARGO_TARGET_DIR="$TARGET_DIR" cargo build --target-dir="$TARGET_DIR"
rm "$SHARED_LIB" 2>/dev/null
rm "$SHARED_LIB_FULL" 2>/dev/null
rm "$SHARED_LIB_MAJOR" 2>/dev/null
cp "$BUILDTYPE"/"$SHARED_LIB" "$SHARED_LIB_FULL"
ln -s "$SHARED_LIB_FULL" "$SHARED_LIB"
ln -s "$SHARED_LIB_FULL" "$SHARED_LIB_MAJOR"

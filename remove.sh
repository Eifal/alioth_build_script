#!/bin/bash

files=(
  "packages/providers/MediaProvider/Android.bp"
  "system/libziparchive/Android.bp"
  "packages/services/Car/tests/CarLibTests/Android.bp"
  "bionic/tests/Android.bp"
  "packages/services/Car/tests/carservice_unit_test/Android.bp"
  "packages/services/Car/tests/OccupantAwareness/Android.bp"
  "packages/services/Car/service/Android.bp"
  "packages/services/Car/tests/carservice_test/Android.bp"
  "packages/services/Car/tools/GenericCarApiBuilder/Android.bp"
  "packages/services/Car/experimental/tests/experimentalcarservice_unit_test/Android.bp"
  "packages/services/Car/tests/vehiclehal_test/Android.bp"
)

for file in "${files[@]}"; do
  if [[ -f $file ]]; then
    sed -i '/default_team/d' "$file"
    echo "Updated $file"
  else
    echo "File $file not found"
  fi
done

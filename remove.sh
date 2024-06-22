#!/bin/bash

find . -name 'Android.bp' -exec sed -i '/default_team/d' {} +

echo "Removed 'default_team' property from all Android.bp files"


#!/bin/bash

find . -name 'Android.bp' -exec sed -i '/default_team/d' {} +

find . -name 'Android.bp' -exec sed -i '/product_variables.pdk/d' {} +

find . -name 'Android.bp' -exec sed -i '/aconfig_declarations/d' {} +

if [ -f "system/update_engine/libbinderwrapper/Android.bp" ]; then
    sed -i '/module "libbinderwrapper_defaults"/,/}/d' system/update_engine/libbinderwrapper/Android.bp
    sed -i '/module "libbinderwrapper"/,/}/d' system/update_engine/libbinderwrapper/Android.bp
    sed -i '/module "libbinderwrapper_test_support"/,/}/d' system/update_engine/libbinderwrapper/Android.bp
fi

echo "Removed unrecognized properties and duplicate modules from Android.bp files"



#!/bin/bash

# This script is useful as a concise reference that serves as a good basis for
# writing the BUILD files.

CFLAGS="-DU_USING_ICU_NAMESPACE=0 \
    -DU_CHARSET_IS_UTF8=1 \
    -DU_NO_DEFAULT_INCLUDE_UTF_HEADERS=1"

    # These two macros break the test shipped with icu source code.
    #-DUNISTR_FROM_CHAR_EXPLICIT=explicit  \
    #-DUNISTR_FROM_STRING_EXPLICIT=explicit \

export CFLAGS

../runConfigureICU Linux/clang \
    --with-library-bits=64
    #--enable-static \
    #--disable-shared
    #--with-data-packaging=static

#include "unicode/ucnv.h"
#include <gtest/gtest.h>
#include <stdio.h>

TEST(UnicodeString, Utf8ToUtf16)
{
  // Uncomment fprintf to see the actual values
  const char     *utf8cstring  = u8"🛁\tμπάνιο\tμπανιέρα";
  const char16_t *utf16cstring =  u"🛁\tμπάνιο\tμπανιέρα";
  const icu::UnicodeString str = icu::UnicodeString::fromUTF8(utf8cstring);
  const int32_t length = str.length();
  for (int32_t i = 0; i < length; i++) {
    fprintf(stderr, "%04X ", str[i]);
    ASSERT_EQ(utf16cstring[i], static_cast<uint32_t>(str[i]));
  }
  fprintf(stderr, "\n");
}

TEST(UnicodeString, Utf8ToUtf32)
{
  const char     *utf8cstring  = u8"🛁\tμπάνιο\tμπανιέρα";
  const char32_t *utf32cstring =  U"🛁\tμπάνιο\tμπανιέρα";

  // Convert UTF8 to UTF16
  const icu::UnicodeString str = icu::UnicodeString::fromUTF8(utf8cstring);

  // Convert UTF16 to UTF32
  UErrorCode err = U_ZERO_ERROR;
  const int32_t char32length = str.countChar32();
  UChar32 *buf = new UChar32[char32length];
  str.toUTF32(buf, 200, err);
  ASSERT_TRUE(U_SUCCESS(err));

  for (int32_t i = 0; i < char32length; i++) {
    fprintf(stderr, "U+%06X ", static_cast<uint32_t>(buf[i]));
    ASSERT_EQ(utf32cstring[i], buf[i]);
  }
  fprintf(stderr, "\n");

  delete []buf;
}

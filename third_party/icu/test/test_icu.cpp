#include "unicode/utypes.h"
#include "unicode/uchar.h"
#include "unicode/locid.h"
#include "unicode/ustring.h"
#include "unicode/ucnv.h"
#include "unicode/unistr.h"

#include <stdio.h>

using icu::UnicodeString;

namespace {

void print_cstring_utf8(const char *str, FILE *fp = stdout)
{
	const char *curr = str;
	while(1) {
		const char ch = *curr;
		if (!ch)
			break;
		fprintf(fp,"U+%02X ", static_cast<uint8_t>(ch));
		curr++;
	}
	fprintf(fp,"\n");
}

void print_cstring_utf16(const char16_t *str, FILE *fp = stdout)
{
	const char16_t *curr = str;
	while(1) {
		const char16_t ch = *curr;
		if (!ch)
			break;
		fprintf(fp,"U+%04X ", static_cast<uint16_t>(ch));
		curr++;
	}
	fprintf(fp,"\n");
}

} // namespace

void print_cstring_utf32(const char32_t *str, FILE *fp = stdout)
{
	const char32_t *curr = str;
	while(1) {
		const char32_t ch = *curr;
		if (!ch)
			break;
		fprintf(fp,"U+%06X ", static_cast<uint32_t>(ch));
		curr++;
	}
	fprintf(fp,"\n");
}
int main(int argc, char const* argv[])
{
	const char     *utf8cstring  = u8"🛁\tμπάνιο\tμπανιέρα";
	const char16_t *utf16cstring =  u"🛁\tμπάνιο\tμπανιέρα";
	const char32_t *utf32cstring =  U"🛁\tμπάνιο\tμπανιέρα";

	printf("\nUTF8:\n");
	print_cstring_utf8( utf8cstring);
	printf("\nUTF16:\n");
	print_cstring_utf16(utf16cstring);
	printf("\nUTF32:\n");
	print_cstring_utf32(utf32cstring);

	{
		printf("\n");
		printf("Testing icu::UnicodeString::fromUTF8:\n");
		const UnicodeString str = UnicodeString::fromUTF8(utf8cstring);
		const int32_t length = str.length();
		for (int32_t i = 0; i < length; i++) {
			printf("U+%04X ", str[i]);
		}
		printf("\n");
	}

	return 0;
}

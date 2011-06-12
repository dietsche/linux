// Removing unecessary code that matches this core pattern:
//	-if(...) return ret;
//	return ret;
//
// Confidence: High
// Copyright: (C) 2011 Greg Dietsche GPLv2.
// URL: http://www.gregd.org
// Comments:
// Options: -no_includes

virtual patch

@depends on patch@
expression ret;
identifier x, y;
identifier f;
identifier is_ordinal_table ~= "IS_ORDINAL_TABLE_\(ONE\|TWO\)";
@@
(
//via an isomorphism this also covers x and unlikely(x)
-if (likely(x)) return ret;
|
-if (\(IS_ERR\|IS_ZERO\)(x)) return ret;
|
-if (is_ordinal_table(x,y)) return ret;
|
if(<+...f(...)...+>) return ret;
|
-if (...) return ret;
)
-return ret;
+return ret;

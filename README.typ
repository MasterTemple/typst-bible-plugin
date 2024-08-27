#import "bible.typ": bible_footnote, bible_quote, bible_quote_fmt

#import "conf.typ": conf
#show: doc => conf(doc)

#show link: underline

// create short-hands
#let ul = underline
#let fn = footnote

#let string(content) = {
	let content = "\"" + content + "\""
	raw(lang: "js", content)
}

= Typst Bible

[insert screenshot here]

#pagebreak()

= Table of Contents
#outline(indent: 2em, title: none)

#pagebreak()

== Purpose

- To easily reference Bible verses for personal, ministerial, or academic papers
- ESV is currently only supported translation #footnote[Since I am the only one using it, and I use ESV, I don't see the need to add another translation. If you use this and would like me to add another translation, let me know.]
- If you have any great ideas, please open a #link("https://github.com/MasterTemple/typst-bible-plugin/issues", "GitHub Issue")

== Import ```js "bible.typ" ```

`bible.typ` is meant to provide an API for interacting with `bible.wasm`

```typ
#import "bible.typ": bible_footnote, bible_quote, bible_quote_fmt
```

== ```typ #bible_footnote() ```

```typ
I am blessed because my sins are forgiven! #bible_footnote("Romans 4:7")
// or
I am blessed because my sins are forgiven! ^ Romans 4:7
// but it is currently broken because there is a bug matching the `:` character
```

I am blessed because my sins are forgiven! #bible_footnote("Romans 4:7")

== ```typ #bible_quote() ```

```typ
#bible_quote("Romans 4:7")
// or
> Romans 4:7
// but it is currently broken because there is a bug matching the `:` character
```

#bible_quote("Romans 4:7")

== ```typ #bible_quote_fmt() ```

Note: Regular Expressions are supported and will be discussed in #link(<regex-support>, "RegEx Support").

==== Basic

This is just like using ```typ #bible_quote()``` with no additional formatting applied

```typ
#bible_quote_fmt("Ephesians 4:28")
```

#bible_quote_fmt("Ephesians 4:28")

==== Bold
#string("b") = bold match pattern (optional)

```typ
#bible_quote_fmt("Ephesians 4:28", b: "doing honest work with his own hands")
```
#bible_quote_fmt("Ephesians 4:28", b: "doing honest work with his own hands")

==== Highlight
#string("hl")   = highlight match pattern (optional)

```typ
#bible_quote_fmt("Ephesians 4:28", hl: "doing honest work with his own hands")
```
#bible_quote_fmt("Ephesians 4:28", hl: "doing honest work with his own hands")

==== Underline
#string("ul")   = underline match pattern (optional)

```typ
#bible_quote_fmt("Ephesians 4:28", ul: "doing honest work with his own hands")
```
#bible_quote_fmt("Ephesians 4:28", ul: "doing honest work with his own hands")

==== Italics
#string("it")   = italics match pattern (optional)

```typ
#bible_quote_fmt("Ephesians 4:28", it: "doing honest work with his own hands")
```
#bible_quote_fmt("Ephesians 4:28", it: "doing honest work with his own hands")

==== Custom
#string("c")    = custom match pattern to apply `fmt` filter (optional)\
#string("fmt")  = custom formatting pattern (optional)

```typ
#bible_quote_fmt("Ephesians 4:28", c: "doing honest work with his own hands", fmt: highlight.with(fill: red))
```
#bible_quote_fmt("Ephesians 4:28", c: "doing honest work with his own hands", fmt: highlight.with(fill: red))

==== Omit/Hide
`omit` = omit content by replacing with elipse ...

```typ
#bible_quote_fmt("Ephesians 4:28", omit: "doing honest work with his own hands")
```
#bible_quote_fmt("Ephesians 4:28", omit: "doing honest work with his own hands")

=== RegEx Support <regex-support>

The parameters for matching are Regular Expressions, you can learn more about them at #link("https://typst.app/docs/reference/foundations/regex/").

==== Removing beginning of quote

This is a common operation

For reference:
#bible_quote_fmt("Ephesians 4:28")

You could say:
```typ
#bible_quote_fmt("Ephesians 4:28", omit: "Let the thief no longer steal, but")
```
To remove #string("Let the thief no longer steal, but")
#bible_quote_fmt("Ephesians 4:28", omit: "Let the thief no longer steal, but")

You could also say:
```typ
#bible_quote_fmt("Ephesians 4:28", omit: "Let.*?rather")
```
To remove everything (#string(".*?")) between #string("Let") to #string("rather") (which equates to #string("Let the thief no longer steal, but"))
#bible_quote_fmt("Ephesians 4:28", omit: "Let.*?rather")

Or you could even say:
```typ
#bible_quote_fmt("Ephesians 4:28", omit: "^.*?rather")
```
To remove everything (#string(".*?")) from the start of the verse (#string("^")) to the first #string("rather") (which again equates to #string("Let the thief no longer steal, but"))
#bible_quote_fmt("Ephesians 4:28", omit: "^.*?rather")

Explanation:
- #string("^") begins the match at the start of the line
- #string(".*") matches anything (#string(".")) as many times as it can (#string("*"))
- #string(".*?") is the same way, but it matches as many as necessary
- In other words, #string(".*rather") will match everything up to #underline[the last] #string("rather"), but #string(".*?rather") will match everything up until #underline[the first] rather

==== Removing end of quote

It is the same thing to remove the end, but you use the #string("$") character:
```typ
#bible_quote_fmt("Ephesians 4:28", omit: ", so.*$")
```
#bible_quote_fmt("Ephesians 4:28", omit: ", so.*$")

This removes everything (#string(".*")) from #string(", so") to the end of the line #string("$") (or #string(", so that he may have something to share with anyone in need.")).

==== Removing beginning and end of quote

```typ
#bible_quote_fmt("Ephesians 4:28", omit: "^.*?rather|, so.*$")
```
#bible_quote_fmt("Ephesians 4:28", omit: "^.*?rather|, so.*$")

This does both

- #string("^.*?rather") starts at the beginning (#string("^")) and removes everything up to (#string(".*?")) the first #string("rather").
- #string(", so.*$") removes everything (#string(".*")) from #string(", so") to the end of the line (#string("$"))
- #string("|") joins the 2 patterns together with a logical `OR` operation, meaning it will do the first pattern or second pattern (and if it can do both, it does both)

== Additional Information

=== Naming

I will try and provide clear naming conventions.
If you do not prefer that, you can just rename them as follows:
```typ
#let v = bible_quote
// ...
#v("1 John 3:2")
```

== Building WASM

To build:

```bash
wasm-pack build --target web
```

I use a script that deletes and re-links the file so that Typst knows to re-check the contents:

```bash
./run.sh
```
# Typst Bible

## Explanation

- Reference Bible verses
- ESV is currently only translation
- Many changes and improvements are planned
- Currently just puts the verse content in a footnote

## Usage

`bible.typ` is meant to provide an API for interacting with `bible.wasm`

### Import `bible.typ`

This includes `r` which is currently how you reference a verse

```typ
import "bible.typ": bible_footnote, bible_quote
```

## `bible_footnote`

### Calling

```typ
I am blessed because my sins are forgiven! #bible_footnote("Romans 4:7")
```

### Result

![](./imgs/bible_footnote.png)

## `bible_quote`

### Calling

```typ
#bible_quote("Romans 4:7")
```

### Result

![](./imgs/bible_quote.png)

### Extra Information

I will try and provide clear naming conventions, and they might be a bit verbose.
However, you can just rename them as follows:
```typ
#let v = set_verse_content_in_footnote
// ...
#v("1 John 3:2")
```
This is a made up example, but you get the point.

## Building WASM

To build:

```bash
wasm-pack build --target web
```

I use a script that deletes and re-links the file so that Typst knows to re-check the contents:

```bash
./run.sh
```

## Screenshots

![](./imgs/screenshot.png)
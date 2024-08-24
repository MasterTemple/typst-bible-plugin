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
import "bible.typ": r
```

### Calling

```typ
I am blessed because my sins are forgiven! #r("Romans 4:7")
```

### Result

![](./imgs/footnote.png)

## Building

To build:

```bash
wasm-pack build --target web
```

I use a script that deletes and re-links the file so that Typst knows to re-check the contents:

```bash
./run.sh
```

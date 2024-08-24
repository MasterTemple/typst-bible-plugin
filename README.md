# Typst WASM Template

## Explanation

- I wanted to create a template for myself to start other plugins from.
- The [wasm_macro](https://github.com/astrale-sharp/wasm-minimal-protocol) code comes from https://github.com/astrale-sharp/wasm-minimal-protocol.
- I adapted it into a structure I think is easier.

## Running

```bash
wasm-pack build --target web
```

## Tips

If you had data in a JSON file and you want it compiled into the .wasm file do this:

```rust
const DATA_JSON: &str = include_str!("data.json");
```

WASM_OUTPUT=~/Development/python/esv/bible/bible.wasm
rm $WASM_OUTPUT
wasm-pack build --target web
ln target/wasm32-unknown-unknown/release/bible.wasm $WASM_OUTPUT

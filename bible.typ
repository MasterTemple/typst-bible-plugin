#let bible = plugin("bible.wasm")
#let greek = json("greek.json")

#let esv(book, chapter, verse) = {
	let translation = "ESV";
	let content = str(bible.get_verse(bytes(book), bytes(str(chapter)), bytes(str(verse)), bytes(translation)))
	[#footnote[#content - #book #chapter:#verse #translation]]
}

#let r(ref) = {
  let book = ref.find(regex("(\d )?\D+")).trim();
  let chapter = ref.find(regex("\d+:")).replace(":", "");
  let verse = ref.find(regex("\d+$"));
	esv(book, chapter, verse)
}

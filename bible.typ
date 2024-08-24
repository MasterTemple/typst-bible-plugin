#let bible = plugin("bible.wasm")

// currently only ESV is supported
#let translation = "ESV";

#let verse_number(n) = {
  [#text(baseline: -0.4em, weight: "bold", size: 7pt, str(n))]
}

#let get_verse_content(book, chapter, verse) = {
	let content = str(bible.get_verse(bytes(book), bytes(str(chapter)), bytes(str(verse)), bytes(translation)));
	content.trim("\"")
}

#let get_verse_content_range(book, chapter, start_verse, end_verse) = {
	let arr = ();
	for verse in range(int(start_verse), int( end_verse)+1) {
		let content = get_verse_content(book, chapter, verse);
		// arr.push([*#super(typographic: false, size: 0.8em, str(verse))* #content]);
		arr.push([#verse_number(verse) #content]);
	}
	arr.join(" ")
}

#let set_verse_footnote(book, chapter, start_verse, end_verse) = {
	let content = get_verse_content_range(book, chapter, start_verse, end_verse);
	let verse = start_verse;
	if start_verse != end_verse {
		verse = [#start_verse\-#end_verse]
	}
	[#footnote[#content - #book #chapter:#verse #translation]]
}

#let parse_ref(ref) = {
  let book = ref.find(regex("(\d )?\D+")).trim();
  let chapter = ref.find(regex("\d+:")).replace(":", "");
  let start_verse = ref.find(regex(":\d+")).replace(":", "");
  let end_verse = ref.find(regex("\d+$"));
	(book, chapter, start_verse, end_verse)
}

#let parse_verse_and_get_content(ref) = {
	let (book, chapter, start_verse, end_verse) = parse_ref(ref)
	let content = get_verse_content_range(book, chapter, start_verse, end_verse);
	content
}

// #let verse(ref) = {
//   let book = ref.find(regex("(\d )?\D+")).trim();
//   let chapter = ref.find(regex("\d+:")).replace(":", "");
//   let start_verse = ref.find(regex(":\d+")).replace(":", "");
//   let end_verse = ref.find(regex("\d+$"));
// 	set_verse_footnote(book, chapter, start_verse, end_verse)
// }

#let block_quote(content, attribution) = {
	let this_quote = pad(y: 0.5em, quote(block: true, attribution: [#attribution])[#content])
	[
		#layout(size => [
			#let (height,) = measure(
				block(width: size.width, this_quote),
			)
			#let height = height
			#let indent = 0em
			#h(indent)
			#box(
				width: 2pt,
				height: height,
				fill: black,
			)
			#place(
				dy: -height,
				dx: indent,
			[#this_quote]
			)
		])
	]
}

#let bible_footnote(..refs) = {
	[#footnote[
		#for ref in refs.pos() {
			[#h(0.5em) #parse_verse_and_get_content(ref) - #ref #translation\ ]
			[#h(1.5em)]
		}
	]]
}

#let bible_quote(..refs) = {
	// let (book, chapter, start_verse, end_verse) = parse_ref(ref)
	for ref in refs.pos() {
		[
			// #quote(attribution: [#ref], block: true)[
			// 	#parse_verse_and_get_content(ref)
			// ]
			#block_quote(parse_verse_and_get_content(ref), ref)
		]
	}
}

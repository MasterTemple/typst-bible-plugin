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
	let this_quote = block(width: 100%,
		pad(x: 0.5em, y: 0.5em, right: 4em,
			quote(block: true, attribution: [#attribution])[
				#par(justify: true, content)
			])
		)
	[
		#layout(size => [
			#let (height,) = measure(
				block(width: size.width, this_quote),
			)
			#let height = height
			#let indent = 2em
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

#let hstack_quote(content, attribution) = {
	let this_quote = block(width: 100%,
		pad(x: 0.5em, y: 0.5em, right: 0.5em,
			quote(block: true, attribution: [#attribution])[
				#par(justify: true, content)
			])
		)
	pad(x: 2em, [
		#layout(size => [
			#let (height,) = measure(
				block(width: size.width, this_quote),
			)
			#let height = height
		  #stack(dir: ltr,
				box(
					width: 2pt,
					height: height,
					fill: black,
				),
				[#this_quote]
			)
		])
	])
}

#let merge_every_other(arr1, arr2) = {
	let arr = ();
	let toggle = false;
	let i1 = 0;
	let i2 = 0;
	while i1 < arr1.len() or i2 < arr2.len() {
		toggle = not toggle;
		if toggle {
	    if i1 == arr1.len() {
				continue
			}
			arr.push(arr1.at(i1));
			i1 += 1;
		} else {
	    if i2 == arr2.len() {
				continue
			}
			arr.push(arr2.at(i2).text);
			i2 += 1;
		}
	}
	arr
}

#let fmt_match(content, pattern, formatter) = {
  let parts = content.split(regex(pattern))
	let matches = content.matches(regex(pattern))
	let alternating_parts = merge_every_other(parts, matches);
	let result = ()
	for (i, part) in alternating_parts.enumerate() {
		if calc.rem(i, 2) == 0 {
			result.push(part)
		}
		else {
			result.push([#formatter(part)])
		}
	}
  result.join()
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
	for ref in refs.pos() {
		let content = parse_verse_and_get_content(ref)
		[
			#hstack_quote(content, [#ref #translation] )
		]
	}
}
// ref = verse reference
// hl = highlight match pattern
// ul = underline match pattern
// it = italics match pattern
// b = bold match pattern
#let bible_quote_fmt1(ref, hl: "", b: "", ul: "", it: "") = {
		let content = parse_verse_and_get_content(ref)
		let new_fields = ()
		for child in content.fields().children {
			if child.has("text") {
					// [#type(child)\ ]
					if hl.len() > 0 {
						child = [#fmt_match(child.text, hl, highlight.with(fill: yellow))]
						// [#child\ ]
						// [#type(child)\ ]
						// [#child.has("text")\ ]
						// [#child.text\ ]
					}
					if b.len() > 0 {
						child = [#fmt_match(child.text, b, text.with(weight: "bold"))]
					}
					if ul.len() > 0 {
						child = [#fmt_match(child.text, ul, underline)]
					}
					if it.len() > 0 {
						child = [#fmt_match(child.text, it, text.with(style: "italic"))]
					}
			}
			new_fields.push(child)
		}
		let content = new_fields.join("")
		[
			#hstack_quote(content, [#ref #translation] )
		]
}

#let apply_function_to_content(content, pattern, fn) = {
		let new_fields = ()
		for child in content.fields().children {
			if child.has("text") {
					if pattern.len() > 0 {
						child = [#fmt_match(child.text, pattern, fn)]
					}
			}
			new_fields.push(child)
		}
		return new_fields.join("")
}


#let apply_fmt_to_content(content, pattern, formatter) = {
		let new_fields = ()
		for child in content.fields().children {
			if child.has("text") {
					if pattern.len() > 0 {
						child = [#fmt_match(child.text, pattern, formatter)]
					}
			}
			new_fields.push(child)
		}
		return new_fields.join("")
}

// `ref`  = verse reference
// `hl`   = highlight match pattern
// `ul`   = underline match pattern
// `it`   = italics match pattern
// `b`    = bold match pattern
// `c`    = custom match pattern to apply `fmt` filter
// `fmt`  = custom formatting pattern
// `omit` = omit content by replacing with elipse ...
#let bible_quote_fmt(ref,
	hl: "", b: "", ul: "", it: "", c: "", fmt: text.with(), omit: ""
) = {
		let content = parse_verse_and_get_content(ref)
		// `hl`  = highlight match pattern
		let content = apply_fmt_to_content(content, hl, highlight.with(fill: yellow))
		// `b`   = bold match pattern
		let content = apply_fmt_to_content(content, b, text.with(weight: "bold"))
		// `ul`  = underline match pattern
		let content = apply_fmt_to_content(content, ul, underline)
		// `it`  = italics match pattern
		let content = apply_fmt_to_content(content, it, text.with(style: "italic"))
		// `c`   = custom match pattern to apply `fmt` filter
		// `fmt` = custom formatting pattern
		let content = apply_fmt_to_content(content, c, fmt)
		// `omit` = omit content by replacing with elipse ...
		let content = apply_function_to_content(content, omit, (text) => text.replace(regex(omit), "..."))
		[
			#hstack_quote(content, [#ref #translation] )
		]
}

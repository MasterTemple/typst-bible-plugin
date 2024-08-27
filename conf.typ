#let conf(
  doc,
) = {
	import "bible.typ": bible_footnote, bible_quote, bible_quote_fmt
	// add paper formatting
	set text(font: "Arial")
	set page(numbering: "[ 1 ]", number-align: bottom + right)

	// add element customization
	show heading.where(level: 1): it => [
		#it
		#line(length: 100%)
	]

	show heading.where(level: 2): it => [
		#pad(
			bottom: -0.5em,
			it
		)
		#line(length: 90%, stroke: 0.8pt)
	]

	show heading.where(level: 3): it => [
		#pad(
			bottom: -0.5em,
			it
		)
		#line(length: 90%, stroke: (thickness: 0.5pt, paint: gray))
	]

 let bible_regex_str = "((?:\d )?\w+(?: of Solomon)?) (\d+).(\d+(?:-\d+)?)?"
	// syntax for easily adding Bible footnotes
	// God loves the world ^ John 3.15
	// let bible_footnote_regex = regex("\^ ?(\w+(?: of Solomon)?) (\d+).(\d+-?\d+)?")
	let bible_footnote_regex = regex("\^ ?" + bible_regex_str)
	show bible_footnote_regex: it => {
		let (book, chapter, verse) = it.text.match(bible_footnote_regex).captures
		[#h(1pt) #bible_footnote(book + " " + chapter + ":" + verse)]
	}

	// syntax for easily adding Bible quotes
	// > John 1:1-2
	let bible_quote_regex = regex("> ?" + bible_regex_str)
	show bible_quote_regex: it => {
		let (book, chapter, verse) = it.text.match(bible_quote_regex).captures
		[#bible_quote(book + " " + chapter + ":" + verse)]
	}


	doc
}

#let conf(
  doc,
) = {
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
	doc
}

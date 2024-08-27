#import "bible.typ": bible_footnote, bible_quote, bible_quote_fmt

#import "conf.typ": conf
#show: doc => conf(doc)

// create short-hands
#let ul = underline
#let fn = footnote

= Theology of Money

== Work for it

#bible_quote("Ephesians 4:28")
#bible_quote("1 Thessalonians 4:11-12")
#bible_quote("2 Thessalonians 3:10")

== What is its purpose?

The best way to approach this is to ask, what does the Scripture say? #fn("As you should ask with everything.")

#bible_quote("Ephesians 4:28")

We see that
we are #ul[to acquire possessions],
to do so #ul[in a lawful manner],
so that we can #ul[share with those who are in need].


#image("./test.excalidraw.svg")

== Giving

// Usage example:
// #bible_quote_fmt(bible_quote("Ephesians 4:28"), "Let the")

// #bible_quote("Ephesians 4:28")
// #bible_quote_fmt("Ephesians 4:28", hl: "thief", b: "so", ul: "anyone", it: "in need")
// #bible_quote_fmt("Ephesians 4:28", hl: "thief", b: "no", ul: "steal", c: "rather let", fmt: highlight.with(fill: red))
// #bible_quote_fmt("Ephesians 4:28", hl: "thief", b: "no", ul: "steal", c: "rather let ", fmt: text.with(size: 0em, ))
#bible_quote_fmt("Ephesians 4:28", omit: "^.+?with")
// #bible_quote_fmt("Ephesians 4:28")
// #bible_quote_fmt("Ephesians 4:28")
// #bible_quote_fmt("Ephesians 4:28")


// #let bible_footnote_regex = regex("\^ ?(\w+) (\d+).(\d+-?\d+)?")
// #show bible_footnote_regex: it => {
//   let (book, chapter, verse) = it.text.match(bible_footnote_regex).captures
// 	[#h(1pt) #bible_footnote(book + " " + chapter + ":" + verse)]
// }

// #let bible_quote_regex = regex("> ?(\w+) (\d+).(\d+-?\d+)?")
// #show bible_quote_regex: it => {
//   let (book, chapter, verse) = it.text.match(bible_quote_regex).captures
// 	[#bible_quote(book + " " + chapter + ":" + verse)]
// }

God loves the world ^ John 3.15

God loves the world ^ John 3.16-17

> John 3.1-3

#bible_quote("Song of Solomon 1:1")

#show regex("((\d+).(\d+))"): (m) => [
	#m #m
]

> Song of Solomon 1:1-2

> Song of Solomon 1.1-2

== Hospitality

// #bible_quote("1 Thessalonians 4:11-12")
// #bible_quote("Matthew 25:31-46")
// #bible_quote("Luke 12:33")
// #bible_quote("Romans 12:13")
// #bible_quote("Hebrews 13:2")
// #bible_quote("1 Peter 4:9")
// #bible_quote("Hebrews 13:16")
// #bible_quote("1 John 3:17")
// #bible_quote("James 2:15-17")
// #bible_quote("Psalm 24:1")
// #bible_quote("Proverbs 3:9-10")
// #bible_quote("Malachi 3:10")
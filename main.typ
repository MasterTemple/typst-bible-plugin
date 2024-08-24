#import "bible.typ": bible_footnote, bible_quote

#for _ in range(26) {
	[\ ]
}

== `bible_quote(<verse>, *)`

=== Usage:

```typ
#bible_quote("John 3:16")
```

=== Displays:

#bible_quote("John 3:16")

== `bible_footnote(<verse>, *)`

=== Usage:

```typ
We should not love the world.#bible_footnote("1 John 2:15")
```

=== Displays:

We should not love the world.#bible_footnote("1 John 2:15")
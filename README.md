This is an attempt to get something resembling Bourbaki's _Elements of Mathematics_
in LaTeX form.

# Example usage

See the example [book](./example-book.tex) and [chapter](./example-chapter.tex)
for examples of how to use this.

# Quirks of the Style

The only sectioning commands available are: chapters, sections,
subsections. (Bourbaki is inconsistent with the terms "section" --- in
chapter 1 of _Lie Groups and Lie Algebras_, they call it a "paragraph",
but throughout _General Topology_ they call it a section. I'm adopting
LaTeX terminology.)

The margins are proportional. If you set the geometry manually, it
appears the inner and outer margins are 0.75 inches.

The section and subsection titling is handled to reflect Bourbaki's
conventions. 

The theorem numbering is done _contra_ Bourbaki's conventions: they all
share the same counter, numbered within the section.

Note that subsections in Bourbaki's books were about 1.5 pages long
(plus or minus 0.5 pages) and that subsections immediately following
`\section{}` commands.

Also, curiously, there are no explicit "proof" environments in Bourbaki
books. 

Equations are numbered within sections, but without prefixing section
numbers to the equation numbers. (See Bourbaki's _Theory of Sets_,
Chapter III, section 1 and section 7, for evidence of this.)

# TODO

- Add an `examples` environment?
- Make list environments pretty
- Add a dangerous bend environment?
- The book configuration (with `usepage` option) appears to have 43
  lines per page, but the (English translation) appears to have 44 lines
  per page. Where is the discrepency?

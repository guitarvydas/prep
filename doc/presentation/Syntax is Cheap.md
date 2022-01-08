# Syntax is Cheap
If you are allowed to use cheap syntax, the way you think about programming changes.

New workflow:
- use macros + toolbox language
- develop multiple notations for a single solution
- base notation on what is *necessary*, not what is *available* in GPLs or DSLs

## Generalized Macro Expansion
Character-based macros
	- not list-only macros
	- PEG (=> Ohm-JS)

PEG libraries are available for many languages.

Ohm is better than PEG because Ohm separates grammar from semantics.
## Names are Cheap => Syntax is Cheap
FP teaches us that names are superfluous.

All syntax is superfluous (not just names).

Projectional Editing strips syntax, leaving only the meat.  PE allows multiple syntaxes for the same meat.
## Learn From Lisp (Racket) Macros
- recursive expansion
- tag syntax objects with File and Line numbers (etc.) 
# Toolbox Language
- Machine Readable (reduced emphasis on human-readability)
- kitchen sink - supports any kind of paradigm
- regular syntax - normalized syntax 
	- easy to read (by machine)
	- easy to write (by machine))


## Original Toolbox
Assembler
- machine readable (after conversion to binary)
- kitchen sink
- normalized syntax - triples.  e.g. "MOV R0,R1" is a triple

Static, compilable and typefulness are optimizations.

All languages can be *dynamic*, but only some can be compiled.

Compilable (static, typeful) languages are for Production Engineering, not Design.

## New Toolbox
Lisp
- machine readable
- kitchen sink
	- every paradigm is possible
	- in fact many languages (e.g. Haskell) were first implemented in Lisp
- normalized syntax - Lisp is an *expression language* (every clause results in a value)
- dynamic first
- REPL
- debugging (well developed over decades)

## Wannabes
### Javascript
- kitchen sink
- supports first-class functions
- easy object creation ("{...}")
- too much syntax
- dynamic
- protypal inheritance (more general (toolbox-y) than class-based inheritance)
## Python
- too much syntax 
- indentation-based syntax is less machine-readable/writable
- dynamic (good for toolbox-iness)
- supports first-class functions
## Relational Programming
- restricted to a single paradigm (Relational)
## OOP
- restricted to a single paradigm (OO)
## Haskell
- restricted to a single paradigm (functions, synchronous-only)
- too much syntax
## Markdown
- line oriented
- editors can easily elide layers
- originally meant for prose but can be applied to programs
## Racket
- lisp, but geared towards compilability (==> trade-offs, language usability degradation)
- accidental complexity whack-a-mole, e.g. closures

# Important Paradigms
## Functional
## OO
## Relational
## Exhaustive Search
## Synchrony
- rendezvous
## Asynchrony
- thread libraries are band-aids ; glue-on asynchrony
- enables isolation (> encapsultion) => black boxes
## Diagrams
- break free of text-only representations
	- reduce accidental complexity of forcing solutions into text-only cubby-holes
- "diagrams" fills the gap between text-only and full-blown VPL (Visual Programming Languages)
- supported by SVG (rectangles, ellipses, lines, text)
- "diagrams" => hybrid of simple graphical elements *plus* text

## Recursion
not Loops
## State
### Case on Type
- OOP
### Case on History
- StateCharts (structured state machines)
### Case on Sequence of Datums
- parsing (Ohm-JS <== PEG)
## Nesting
- aka "scoping"
- aka "namespaces"
- aka "packaging"

## Parsing
- aka "pattern matching"
- pattern matching currently in vogue in FP languages

## Dependency
- seen to be a bad idea
- =>violates isolation
## Isolation
- build and forget
- no dependencies between components (data dependencies *and* control-flow dependencies)
### Encapsulation
- "encapsulation" is an isolation wannabe, but fails to encapsulate control-flow
## Control Flow
- 1/2 of Turing Machine
- like the playback head in a tape recorder
- distributed computing
	- internet
	- p2p
	- IoT
	- autonomous robotics
## Data Flow
- 1/2 of Turing Machine
- like the magnetic tape in a tape recorder
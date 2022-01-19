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

Lisp provides powerful macros, but using a list-only syntax.

PEG provides lisp-like power using a character-based syntax.

PEG libraries are available for many languages.

Ohm is better than PEG because Ohm separates grammar from semantics.
## Names are Cheap => Syntax is Cheap
FP teaches us that names are superfluous.

All syntax is superfluous - not just names.

PE (Projectional Editing) strips syntax, leaving only the meat.  PE allows multiple syntaxes for the same meat.
## Learn From Lisp (Racket) Macros
Lisp taught us what makes a good macro DSL and how to expand macros.
- recursive expansion
- tag syntax objects with File and Line numbers (etc.) (Scheme, Racket)
# Toolbox Language
- Machine Readable (reduced emphasis on human-readability)
- kitchen sink - supports any kind of paradigm
- regular syntax - normalized syntax 
	- easy to read (by machine)
	- easy to write (by machine)


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
- debugging (debuggers well developed over decades)

## Wannabes
### Javascript
- kitchen sink
- supports first-class functions
- easy object creation ("{...}")
- too much syntax
- not an expression language ; needs `return` statements
- dynamic
- protypal inheritance (more general (toolbox-y) than class-based inheritance)
## Python
- too much syntax 
- indentation-based syntax is less machine-readable/writable
- dynamic (good for toolbox-iness)
- supports first-class functions
## Relational Programming
- restricted to a single paradigm (Relational)
- wonderful for pattern-matching higher-level concepts (aka *inference*)
- syntax developed for inferencing
- can support and query triples
- the underlying *mechanism* for relational programming is *exhaustive search* (PROLOG and miniKanren achieve exhaustive search in different ways) (see below)
## OOP
- restricted to a single paradigm (OO)
- the underlying *mechanism* for "message sending" is usually implemented as CALL-RETURN (produces implicit dependencies)
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
- *everything-is-a-function* syntax is a normalized syntax
- conflated with isolation and explicit-iness (see below)
## OO
- *everything-is-an-object-with-state*
- suffers from being unwittingly implemented in a synchronous paradigm using synchronous languages
- add multi-tasking => Actors
## Exhaustive Search
- Query that returns all possible answers
- fundamental mechanism of PROLOG
	- but, PROLOG added optimizations, since it used backtracking, which was expensive in 1950's technology
	- see [Nils Holm's PROLOG Control in 6 Slides](https://www.t3x.org/bits/prolog6.html)
- miniKanren accomplishes exhaustive search without using backtracking
## Synchrony
- a programming paradigm that is useful for building calculators
- it was originally thought that computers were just calculators (for calculating ballistics)
- computers also can perform sequencing, which does not fit easily into the synchronous paradigm
- rendezvous
## Asynchrony![[layer 0 Screen Shot 2022-01-07 at 3.20.53 PM.png]]
- thread libraries are band-aids ; glue-on asynchrony
- enables isolation (> encapsultion) => black boxes
- fundamental mechanism for distributed
- cannot use stack (lest you send the stack down a single wire)
- often confused with parallelism (parallelism is an optimization, concurrency is a paradigm)
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

## Explicit-iness
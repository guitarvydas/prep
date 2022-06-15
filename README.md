#prep

*Prep* is a simple command-line tool that processes arbitrary text.

*Prep* has 3 inputs, plus some parameters:
1. source code text
2. grok specification (grammar, `.ohm` file) 
3. replacement formatting specification (`.fmt` file)

*Prep* works on text using begin/end brackets that are REGEXPs.

*Prep* applies the grok/reformat cycle (2&3) repeatedly until the brackets no longer match any text.

The prep command-line is:
```
prep re1 re2 grammar fmt --fmt=.../fmt.js --grammarname="..." --inclusive <src
```

where 
- re1 is the REGEXP defining the beginning bracket of a chunk of text within the src, 
- re2 is the REGEXP definining the ending bracket of a chunk of text
- *grammar* is a `.ohm` file containing one or more grammars in Ohm-JS format
- *fmt* is a `.fmt` file in *glue* format (see below)
- *--fmt=...* is a javascript file containing support code and referenced as the `fmt.` object
- *--grammarname="..."* is a string containing the name of an Ohm-JS grammar
- *<src* is input text redirected from a file
- *--inclusive* is a command-line flag that specifies that the chunk of text begin with re1 and end with re2 (otherwise the chunk begins with re1, but, re2 is left off of the end of the chunk)

*Prep* currently has a number of options, mostly for development of *prep*.  Not all options will be supported moving forward.
- --errorview
- --grammarname="..."
- --inclusive
- --split
- --stop=1
- --support=...
- --fmt=...
- --trace
- --input=...
- --view
- <...

- --errorview
	- Ohm-JS .trace on parsing failure
	- Ohm-editor is a more convenient way to display / examine parsing errors
- --grammarname="..."
	- string containing the name of the Ohm-JS grammar to be used
- --inclusive
	- include chunk beginning and end in each chunk
	- otherwise, chunk begins with beginning REGEXP, but, ends just before ending REGEXP
- --split
	- display each code chunk before it is fed to Ohm-JS
- --stop=1
	- do not work recursively
	- usually used in conjunction with '.' '$' as the bracket REGEXPs to process the complete file once
- --support=...
	- support filename containing Javascript, referenced as `support.`
	- likely to be deprecated in lieu of *--fmt=*
- --fmt=...
	- support filename containing Javascript, referenced as `fmt.`
- --trace
	- print depth and rulename on entering / exiting a *glue* rule
- --input=...
	- input filename (used when input redirection is not supported, e.g. VSCode)
- --view
	- display code chunk after expansion
- <...
	- take input source text from filename


REGEXPs are in Javascript format (passed directly to Javascript), e.g. '❮' for the beginning bracket of a chunk and '❯' for the ending bracket of a chunk of text

Example line:

```
${prep} '❮' '❯' ${grammar} ${identity-format} ${support} --errorview --inclusive <${src}
```

Note that, in a Makefile, `$` as a REGEXP must be specified as `'$$'` (make syntax for escaping a single `$`)

## Glue Format
#fmt 

Each *glue* rule is transpiled into a Javascript function that produces exactly 1 *template string* and returns it.

[Aside: the name *glue* is due to historical reasons, something along the lines of *gluing bits of text together to transpile source code*]

```
ruleName [ ... parameters ... ] = {{ ... down code ... }}[[... up re-formatting code ...]]
```
A *glue* spec consists of 1 line for every rule in the corresponding `.ohm` grammar.

Each *glue* spec line begins with the name of the *glue* rule, which must match a rule in the corresponding `.ohm` grammar.

There must be exactly one *glue* rule for every grammar rule.

Following the rule name is a list of parameters enclosed in single square brackets.

Each parameter is a single identifier, as defined by Javascript.

There must be exactly 1 parameter for every match element (AKA parsing expression) in the corresponding grammar rule.  The Ohm-JS matcher binds the captured match to each corresponding parameter.

Parameters that correspond to repetition parsing expressions must be prefixed by `@`.  Repetition parsing expressions have one of the following suffixes in the grammar:
- `+`
- `*`
- `?`

*Down code* is any valid Javascript code.  *Glue* rule parameters are referred to using the prefix `_`.  *Down code* is rarely used, usually in exceptional circumstances.

*Up re-formatting code* is any valid Javascript character that can appear in a Javascript *template string*.  Namely
- ${...} evaluates the Javascript expression inside the braces and substitutes the result into the resulting string
- all other characters are copied verbatim to the final result string.

*Up re-formatting code* is the normal usage and appears in every *glue* rule.

Note that `@` causes full evaluation of the repetition capture and `.join`s the results into a single return string.

Example:
```
IfStatement [kif Expr klbrace1 ThenPart krbrace1 kelse klbrace2 ElsePart krbrace2] = \[\[if (${Expr}) {${ThenPart}} else {${ElsePart}}]]
```
might be a *glue* rule that corresponds to a grammar rule
```
IfStatement = "if" Expr "{" ThenPart "}" "else" "{" ElsePart "}"
```

[I use `k` as a prefix to signify string constants bound to *glue* parameters]

Note that the above example ignores the string constant parameters and hard-wires specific characters into the resulting *template string*.  Ignoring parameters is easy in Javascript - I just don't use them at all.

Note: the syntax is not very amenable to human reading and could use an upgrade.  As such, though, I have never felt compelled to need to change the syntax.  The unreadable syntax above has been sufficiently useful in its present (ugly) form.

Note: (*for Ohm-JS aficianados, ignore this note otherwise*) the syntax used for *glue* specifications is coded in the *prep* code Javascript file as "glueGrammar".  The semantic operation name is `_glue()`.  The semantic rules for transpiling *glue* syntax to Javascript (*glueSemantics*) create one Javascript function for each rule.  The function parameters correspond to the given names, with a `_` prefix character.  The parameters are, each, evaluated by calling `._glue ()` for non-repetition parameters and `._glue ().join ('')` for repetition parameters.  The evaluated values are stored in local variables that correspond directly with the parameter names (no `_` prefix) and, can be used as-is in the re-format RHSs of the *glue* rules.  Each parameter has 2 lives - before evaluation (as a CST node) and after evaluation (as a string).  The CST captures are bound to the `_` parameters, and, the evaluated values are bound to non-`_` names.  "Down code" is executed before any evaluation takes place and can only refer to the `_` CST parameters.  "Up code" can refer to local variables without the `_` prefixes.  The generated code will become clear upon inspection of various examples.  The generated code does not attempt any optimization, and, blindly evaluates all CST expressions regardless of whether they are used in the code or not.  Lack of optimization descends to the character level.  `This.sourcestring` is used only in the `terminal` rule.  All other rules blindly call `._glue ()...` without attempting any optimizations.  *Glue* is meant to be used in developing code where turn-around of experimental code is more important than wasted CPU cycles. *Glue* is meant for use on souped-up development machines instead of in production code.

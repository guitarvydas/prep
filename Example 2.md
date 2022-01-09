Let's write a grammar to do more interesting macro pattern-matching.

# Grammar
```
G {
  start = findMacros*
  findMacros =
    | applySyntactic<Macro> -- macro
    | ident                  
    | any

  Macro = 
    | tIdentMacro "(" ListOf<ident, ","> ")"
    | tAnythingMacro "(" anystuff* ")"

  anystuff =
    | "(" anystuff* ")"  -- nested
    | ~"(" ~")" any      -- flat

  ident = identFirst identRest*
  identFirst = "A" .. "Z" | "a" .. "z" | "_" 
  identRest = "0" .. "9" | identFirst

  tAnythingMacro = "m" ~identRest
  tIdentMacro = "i" ~identRest

}

```
The above grammar provides 2 kinds of macros:
1. macros that expect `ident`s as parameters (`m()`)
2. macros that allow anything as parameters (`i()`).

Kind 2 macros (match anything inside parameter list) use PEG's ability to pattern-match for matching parentheses (see the rule `anystuff`).

Kind 1 macros will pattern-match only identifiers (as defined by the rule `ident`) separated by commas, and, will balk at anything else.

We used `m` and `i` as macro names in this example, but, any names could be used.
# Test Code
```
f
zi(d,e)
i(p,q)
m(r,s)
g
i
(a,
b)
h
```
# Synopsis

Source code transpiler that works on blocks of text bracketed by REGEXPs, using PEG to transpile the blocks.

[The documentation contains videos.  For now: pull the repo, view documentation in Obsidian.]

# Usage

prep 're-begin' 're-terminate' ohm-spec glue-spec \<in \>out

prep 're-begin' 're-terminate' ohm-spec glue-spec --input=in

prep 're-begin' 're-terminate' ohm-spec glue-spec --support=fname [...]

prep 're-begin' 're-terminate' ohm-spec glue-spec --cycles=1 [...]

prep 're-begin' 're-terminate' ohm-spec glue-spec --inclusive [...]

Expansion is recursive except when --cycles is specified. When --cycles is specified, an internal counter is initialized to 0 and counts upward +1 for every expansion cycle. Expansion terminates when (counter >= stop). 

The option ``-exclusive`` causes `prep` to exclude the terminator match from the code blocks

See `run.bash` 

# Examples

See `run.bash`

[[Test1]]

# Recursive Expansion
N.B. The expanding is done recursively.  

If you need to expand a block into another block which contains the same begin-regex, the expansion will go into an infinite loop. 

An example of how to handle this case is in test6, e.g. expand `query` into `~`, then later, used `sed` to put the `query` back, noting that `~` will not trigger a re-expansion, i.e. `## query` is mapped to `## ~` then later re-mapped to `## query`.

# Documentation

See [Ohm-JS documentation](https://github.com/harc/ohm) for how to write an Ohm spec.

See [Glue Tools](https://guitarvydas.github.io/2021/04/11/Glue-Tool.html) for how to write a Glue Spec.

See JavaScript Regex documentation for how to write begin/terminated REGEXs.


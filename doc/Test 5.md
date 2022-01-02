## input
```
hello
world
third line

```
## Test5.ohm
```
test5 {
main = ruleany+
ruleany = any
}
```

## Test5.glue
```
main [@ruleany] = [[<elided>]]
ruleany [c] = [[${c}]]
```

## Command
```
prep '.' '$' test5.ohm test5.glue --stop=1 --input=test5
```
## Reading
![[tests-test 5.svg]]
Pattern matching matches anything (`.`) and terminates at EOF (`$`).

`Stop=1` is specified to stop cycling after the first round of matching.

The whole match is replaced by the string "<elided>".

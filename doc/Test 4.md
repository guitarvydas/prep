## input
```
abababc
```
## Test2.ohm
(test4 reuses test2.ohm)
```
test2 {
main = rulea
rulea = "ab"
}
```

## Test2.glue
(test4 reusues test2.glue)
```
main [rulea] = [[*]]
rulea [twoc] = [[${twoc}]]
```

## Command
```
prep 'ab' 'ab|c' test2.ohm test2.glue --input=test4
```
## Reading
![[tests-test 4.svg]]
Pattern matching and formatting is similar to test3, except that it happens three times, with the result `***c`.

Note that the termination REGEX is now `ab|c` which matches "ab" or matches "c".
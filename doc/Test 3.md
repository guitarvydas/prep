## input
```
abcabc
```
## Test2 .ohm
(test3 reuses test2.ohm)
```
test2 {
main = rulea
rulea = "ab"
}
```

## Test2.glue
(test3 reusues test2.glue)
```
main [rulea] = [[*]]
rulea [twoc] = [[${twoc}]]
```

## Command
```
prep 'ab' 'c' test2.ohm test2.glue --input=test3
```
## Reading
![[tests-test 3.svg]]
Pattern matching and formatting is similar to test2, except that it happens twice, with the result `*c*c`.
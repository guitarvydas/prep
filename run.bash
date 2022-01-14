#!/bin/bash
app=${HOME}/app
${app}/make.bash
cdir=`pwd`
prep=./prep
echo running test1 '(should print *c)'
${prep} 'a' 'c' test1.ohm test1.glue --input=test1 --exclusive
#${prep} 'a' 'c' test1.ohm test1.glue <test1
echo running test2 '(should print *c)'
${prep} 'ab' 'c' test2.ohm test2.glue --input=test2 --exclusive
echo running test3 '(should print *c*c)'
${prep} 'ab' 'c' test2.ohm test2.glue --input=test3 --exclusive
echo running test4 '(should print ***c)'
${prep} 'ab' 'ab|c' test2.ohm test2.glue --input=test4 --exclusive
echo running test5 '(should print <elided>)'
${prep} '.' '$' test5.ohm test5.glue --stop=1 --input=test5 --exclusive
echo running test forall
${prep} '#+ forall' '#+ ' forall.ohm forall.glue --input=testforall --support=${cdir}/support.js --exclusive
echo running test implicit forall
${prep} '#+ query' '#+ ' implicitforall.ohm implicitforall.glue --input=testimplicitforall --support=${cdir}/support.js  --exclusive >temp
sed -E -e 's/~/query\n/g' <temp
rm -f temp

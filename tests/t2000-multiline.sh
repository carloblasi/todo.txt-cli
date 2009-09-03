#!/bin/sh

test_description='Multi-line functionality'

. ./test-lib.sh

## Replace test
# Create the expected file
echo "1: smell the cheese
replaced with
1: eat apples eat oranges">$HOME/expect.multi

test_expect_success 'multiline item replace' '
(
# Prepare single line todo file
cat /dev/null > $HOME/todo.txt
"$HOME/bin/todo.sh" add smell the cheese

# Run replace
"$HOME/bin/todo.sh" replace 1 "eat apples
eat oranges" > $HOME/output.multi

# Test output against expected
diff "$HOME/output.multi" "$HOME/expect.multi"
if [ $? -ne 0 ]; then
  exit 1
else
  exit 0
fi
)
'

## Add test
# Create the expected file
echo "TODO: 'eat apples eat oranges' added on line 2.">$HOME/expect.multi

test_expect_success 'multiline item add' '
(
# Prepare single line todo file
cat /dev/null > $HOME/todo.txt
"$HOME/bin/todo.sh" add smell the cheese

# Run add
"$HOME/bin/todo.sh" add "eat apples
eat oranges" > $HOME/output.multi

# Test output against expected
diff "$HOME/output.multi" "$HOME/expect.multi"
if [ $? -ne 0 ]; then
  exit 1
else
  exit 0
fi
)
'

## Append test
# Create the expected file
echo "1: smell the cheese eat apples eat oranges">$HOME/expect.multi

test_expect_success 'multiline item append' '
(
# Prepare single line todo file
cat /dev/null > $HOME/todo.txt
"$HOME/bin/todo.sh" add smell the cheese

# Run append
"$HOME/bin/todo.sh" append 1 "eat apples
eat oranges" > $HOME/output.multi

# Test output against expected
diff "$HOME/output.multi" "$HOME/expect.multi"
if [ $? -ne 0 ]; then
  exit 1
else
  exit 0
fi
)
'

## Prepend test
# Create the expected file
echo "1: eat apples eat oranges smell the cheese">$HOME/expect.multi

test_expect_success 'multiline item prepend' '
(
# Prepare single line todo file
cat /dev/null > $HOME/todo.txt
"$HOME/bin/todo.sh" add smell the cheese

# Run prepend
"$HOME/bin/todo.sh" prepend 1 "eat apples
eat oranges" > $HOME/output.multi

# Test output against expected
diff "$HOME/output.multi" "$HOME/expect.multi"
if [ $? -ne 0 ]; then
  exit 1
else
  exit 0
fi
)
'

test_done
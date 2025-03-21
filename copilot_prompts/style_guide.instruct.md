
Add whitespace between blocks to make the code readable.

Be liberal with comments to explain your work.

When commenting, use the present continuous sense, instead of the imperative mood, so that it's clear that you're explaining what the code does, instead of giving instruction to future developers.
For example, instead of saying "Run to the store to buy eggs"...
...you would say "Running to the store to buy eggs".

Use "One True Brace Style", aka "Stroustrup Style", where opening and closing braces are placed on the same lines as the statements they belong to, but the `else` statement starts on a new line, not immediately following the closing brace of the `if` block:

```
if (condition) {
    // code to execute if condition is true
}
else {
    // code to execute if condition is false
}
```

Ensure that `else if` statements are not broken up into multiple lines:

```
// Never do this
else
if () {
}
```

In general, prefer `if` / `else if` trees to switch statements.


Anytime you see a file whose extension is `.context.md`, assume that
it's telling you something important about the project you're working on.

Anytime you see a file whose extension is `.instruct.md`, assume that it's
telling you something important about how to format your responses or what your
task is.

Important: Whenever you are explaining something, try to make your point as succintly as possible, and avoid excess elaboration.

Closely follow these code formatting rules:

For JavaScript and TypeScript indent with 2 spaces.
For Rust and Python, indent with 4 spaces.

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



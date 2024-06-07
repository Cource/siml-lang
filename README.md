# SiML - A markup lanugage for people who actually type
You might have guessed that 'ML' in SiML stands for 'Markup Language', Si is supposed to be an acronym for SImple, but it very well could be Silicon.

# Why?
HTML is just too much characters. And, LISP just is really nice for markup.
Siml looks like this:
  [html
  [head [title "An HTML page"]]
  [body [h1 "This is a Heading"]]]
Compiled to HTML:
  <html>
  <head><title>An HTML page</title></head>
  <body><h1>This is a Heading</h1></body>
  </html>

# Language Syntax
Definiton: [element-name <optional-attribute-set> <optional-children>]
  Where:
    <optional-attribute-set>: () or (key="value") or nothing
    <optional-children>: "text" or more siml
Example:
  [element-name(attribute1="value" flag-attribute) "string" [child-element]]

# Build
- Step 1: Have Nix
- Step 2: Clone this repo
```sh
git clone
```
btw, you need the git program to do this.
- Step 3: Know how to use Nix
- Step 4: If you don't know, you can just run
```sh
nix-build
```
make sure you are in the root of this project before you do run it
```sh
cd siml-lang
```
- Step 5: After the build is complete, the executable should be in
`dist-newstyle/build/x86_64-linux/ghc-9.4.8/siml-hs-0.1.0.0/x/siml/build/siml/siml`
or somewhere similar (the version numbers could be different)

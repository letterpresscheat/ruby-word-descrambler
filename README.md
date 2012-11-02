Ruby Word Descrambler
=====================

Trie implementation for solving word games

This is the solver used in http://letterpresscheat.com

###Usage (`irb`)###
Build the Trie using the dictionary:

```
      require './trie'
      trie = Trie.new
      dictionary = IO.read("dict.txt").split("\n")
      puts "dict has #{dictionary.size} words."
      trie = Trie.new
      dictionary.each do |word|
        trie.build(word)
      end
```

Get the results:

```
      board = "ABCDEFGHIJKLMNOPQRSTUVXYZ"
      trie.solve board
```

`solve` returns an array of words

This example expects dict.txt to be a list of words separated by newlines.
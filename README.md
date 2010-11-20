# Redcar Align Plugin

Adds smart aligning to Redcar. When you hit `Ctrl+Q` without a selection, the
current paragraph is aligned to fit into the margin. If you have text selected,
all paragraph in that selection will be aligned. Keeps paragraph indentation and
is able to handle lists.

## Example

    foo bar
    blah blubb lorem ipsom okay okay
    
    * this is some very nice listing you've got here
    * oh god,
            my indentation is wrong
    
    As I said:
    
        it keeps the initial indentation level
        for each paragraph.

Becomes:

    foo bar blah blubb lorem ipsom okay
    okay
    
    * this is some very nice listing
      you've got here
    * oh god, my indentation is wrong
    
    As I said:
    
        it keeps the initial indentation
        level for each paragraph.

## Stand-alone usage

It can be used without Redcar:

    require 'aligner'
    Aligner.align File.read("README"), 80


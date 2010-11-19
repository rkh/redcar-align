require 'aligner'

module Redcar
  class Align < DocumentCommand
    def self.menus
      Menu::Builder.build { sub_menu("Edit") { item "Align Paragraph", Redcar::Align }}
    end

    def self.keymaps
      [Keymap.build("main", [:osx, :linux, :windows]) { link "Ctrl+Q", Redcar::Align }]
    end

    def execute
      if doc.selection?
        first, last = doc.selection_range.begin, doc.selection_range.end
      else
        first = doc.offset_at_line doc.cursor_line
        last  = doc.cursor_offset
      end
      first, last = seek(first, -1), seek(last, 1) + 1
      content     = doc.get_slice(first, last)
      doc.replace first, last - first + 1, Aligner.align(content, doc.edit_view.margin_column)
    end

    def seek(start, direction)
      start += direction until start <= 0 or start >= doc.length or doc.get_slice(start, doc.length) =~ /^\n\s*\n/m
      start -= 1 if start == doc.length
      start -= 1 while start > 1 and doc.get_range(start, 1) =~ /\s/
      start
    end
  end
end

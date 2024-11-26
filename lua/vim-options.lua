vim.opt.relativenumber = true
vim.g.mapleader = " "

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.cmd("command! MPT MarkdownPreviewToggle")

-- A keymap to paste C++ header file template
vim.keymap.set("n", "<leader>th", function()
  local filename = vim.fn.input("Header name (no .h): ")
  vim.api.nvim_put(
    {
      string.format("#ifndef %s_H", filename),
      string.format("#define %s_H", filename),
      "",
      "",
      string.format("#endif  // %s_H", filename),
    },
    "c", -- Place lines below the cursor
    true, -- Start undo sequence
    false  -- Move the cursor to the end of the inserted text
  )
end)


-- Create a keymap to paste C++ main function template
vim.keymap.set("n", "<leader>tm", function()
  vim.api.nvim_put(
    {
      "#include <iostream>",
      "#include <vector>",
      "",
      "int main() {",
      "",
      "\treturn 0;",
      "}",
    },
    "c", -- Place lines below the cursor
    true, -- Start undo sequence
    false  -- Move the cursor to the end of the inserted text
  )
end)


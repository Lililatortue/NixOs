



local function smart_jump() 
      local view = require("nvim-tree.view")
      if view.is_visible() and vim.bo.filetype == "NvimTree" then
            vim.cmd("wincmd p")
      else
            vim.cmd("NvimTreeFocus")
      end
end


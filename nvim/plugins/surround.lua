local present, sourround = pcall(require, "nvim-surround")

if not present then
  return
end

local keymaps = {
  insert = "<C-g>s",
  insert_line = "<C-g>S",
  normal = "ys",
  normal_cur = "yss",
  normal_line = "yS",
  normal_cur_line = "ySS",
  visual = "S",
  visual_line = "gS",
  delete = "ds",
  change = "cs",
}

sourround.setup {
  keymaps = keymaps,
}

-- image viewer intergration:
return { -- TODO:
  '3rd/image.nvim', -- allows image view in preview
  build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  opts = {
    processor = 'magick_cli',
  },
  -- INFO: Default: https://github.com/3rd/image.nvim?tab=readme-ov-file#default-configuration
}

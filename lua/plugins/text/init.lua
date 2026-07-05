-- markdown.md, org.org, text.txt, ...
-- For `plugins/markview.lua` users.
return {

  --[[ markdown ]]
  -- require 'plugins.text.markview',
  -- require 'plugins.text.mkdnflow',
  require 'plugins.text.markdown-plus',

  --[[ other text-filetype ]]
  require 'plugins.text.orgmode',

  --[[ other text-util ]]
  require 'plugins.text.todo-comments',
  require 'plugins.text.screenkey',
}

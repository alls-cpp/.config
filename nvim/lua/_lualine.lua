-- solarized
-- local colors = {
--     red = '#dc322f',
--     grey = '#002b36',
--     black = '#073642',
--     white = '#eee8d5',
--     light_green = '#859900',
--     orange = '#d33682',
--     green = '#2aa198',
--     yellow = '#b58900',
--     violet = '#6c71c4',
--   }
  local colors = {
    red = '#ff5555',
    grey = '#44475a',
    black = '#282a36',
    white = '#f8f8f2',
    light_green = '#50fa7b',
    orange = '#ff79c6',
    green = '#8be9fd',
    yellow = '#ffb86c',
    violet = '#bd93f9',
  }
  -- Black	#282a36	
  -- Grey	#44475a	
  -- White	#f8f8f2	
  -- Dark Blue	#6272a4	
  -- Cyan	#8be9fd	
  -- Green	#50fa7b	
  -- Orange	#ffb86c	
  -- Pink	#ff79c6	
  -- Purple	#bd93f9	
  -- Red	#ff5555	
  -- Yellow	#f1fa8c

  local theme = {
    normal = {
      a = { fg = colors.white, bg = colors.black },
      b = { fg = colors.white, bg = colors.grey },
      c = { fg = colors.black, bg = colors.white },
      z = { fg = colors.white, bg = colors.black },
    },
    insert = { a = { fg = colors.black, bg = colors.light_green } },
    visual = { a = { fg = colors.white, bg = colors.violet } },
    replace = { a = { fg = colors.black, bg = colors.green } },
  }
  
  local empty = require('lualine.component'):extend()
  function empty:draw(default_highlight)
    self.status = ''
    self.applied_separator = ''
    self:apply_highlights(default_highlight)
    self:apply_section_separators()
    return self.status
  end
  
  -- Put proper separators and gaps between components in sections
  local function process_sections(sections)
    for name, section in pairs(sections) do
      local left = name:sub(9, 10) < 'x'
      for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
        table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
      end
      for id, comp in ipairs(section) do
        if type(comp) ~= 'table' then
          comp = { comp }
          section[id] = comp
        end
        comp.separator = left and { right = '' } or { left = '' }
      end
    end
    return sections
  end
  
  local function search_result()
    if vim.v.hlsearch == 0 then
      return ''
    end
    local last_search = vim.fn.getreg('/')
    if not last_search or last_search == '' then
      return ''
    end
    local searchcount = vim.fn.searchcount { maxcount = 9999 }
    return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
  end
  
  local function modified()
    if vim.bo.modified then
      return '+'
    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
      return '-'
    end
    return ''
  end
  
  require('lualine').setup {
    options = {
      theme = theme,
      component_separators = '',
      section_separators = { left = '', right = '' },
    },
    sections = process_sections {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        'diff',
        {
          'diagnostics',
          source = { 'nvim' },
          sections = { 'error' },
          diagnostics_color = { error = { bg = colors.red, fg = colors.black } },
        },
        {
          'diagnostics',
          source = { 'nvim' },
          sections = { 'warn' },
          diagnostics_color = { warn = { bg = colors.yellow, fg = colors.black } },
        },
        { 'filename', file_status = false, path = 1 },
        { modified, color = { bg = colors.orange, fg = colors.black } },
        {
          '%w',
          cond = function()
            return vim.wo.previewwindow
          end,
        },
        {
          '%r',
          cond = function()
            return vim.bo.readonly
          end,
        },
        {
          '%q',
          cond = function()
            return vim.bo.buftype == 'quickfix'
          end,
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { search_result, 'filetype' },
      lualine_z = {},
    },
    inactive_sections = {
      lualine_c = { '%f %y %m' },
      lualine_x = {},
    },
  }
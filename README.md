# sandbox

notes as code.

This plugin is a wrapper of [ideas-sandbox](https://github.com/dcoello-dev/ideas-sandbox) cli tool.

There are a lot of notes applications around there (notion, obsian etc etc) but as a developer even if I write a lot of notes I rarely found myself coming back and reading it.

I use a lot godbolt to draft ideas before implement it or to share it with other devs to show or explain ideas but it is difficult for me to track all the godbolts that I write.

I also find my self going through my github projects trying to find implementations or ideas that are similar to what I am doing on this moment and I want to check how I did it.

whit this two things in mins I decided to create another notes app, but on this case I want to create a mix of godbolt and notes application where to develop my small ideas and have the chance to come back to those implementations and check how I did it in an easy and flexible workflow.

## principles

This plugin is based on a few key ideas:
- each idea is self contained in one file, if you need more than one file it is not an idea, it is a project.
- each idea can have implementations in several languages, all implementations will be stored on same folder so you can check how the same thing can be done in different languages.
- each idea can be explained in the source code as comments, if it is not enough you can write a markdown version of the idea.

## installation

`sandbox.nvim` is based on [ideas-sandbox](https://github.com/dcoello-dev/ideas-sandbox) cli tool, first install it:

```bash
pip install ideas-sandbox
```

Then install neovim plugin, it depends on telescope and toggleterm.

```lua
  {
    'dcoello-dev/sandbox.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'akinsho/toggleterm.nvim',
    },
    config= function()
      require("sandbox").setup({
        work_idea_path="/home/user/codebase/",
        ideas_path="/home/user/codebase/",
        execute_km = '<leader>gw',
        open_km = '<leader>gl',
        work_idea_km = '<leader>gm'
      })
    end
  },
```

## usage

There are three commands:
- **SReset** cpp/py/md/bash : creates a new main of this language.
- **SSave** : save current idea.

There are a few keymaps you can override it in your conf:
- **<leader>gw** : run pipeline for current idea.
- **<leader>gm** : go to current idea.
- **<leader>gl** : search ideas.

# sandbox

notes as code.

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

I recommend to fork this repository to keep your ideas close to the framework so you can adapt it to your needs.

Just install neovim plugin, it depends on telescope, toggleterm and glow.

```lua
{
  'dcoello-dev/sandbox.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'akinsho/toggleterm.nvim',
    'ellisonleao/glow.nvim',
  },
  config = function
    require("sandbox").setup({storage_path="~/path/to/your/ideas/"})
  end
},
```

## usage

There are three commands:
- SReset cpp/py/md/bash : creates a new main of this language.
- SLoad : search through ideas.
- SSave : save current idea.

There are a few keymaps:
- <leader>gw : run pipeline for current idea.
- <leader>gm : go to current idea.
- <leader>gl : search ideas.

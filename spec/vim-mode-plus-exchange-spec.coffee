requireFrom = (pack, path) ->
  packPath = atom.packages.resolvePackagePath(pack)
  require "#{packPath}/#{path}"

{getVimState} = requireFrom 'vim-mode-plus', 'spec/spec-helper'

describe "vim-mode-plus-exchange", ->
  [set, ensure, keystroke, editor, editorElement, vimState] = []

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('vim-mode-plus-exchange')

    getVimState (state, vimEditor) ->
      vimState = state
      {editor, editorElement} = vimState
      {set, ensure, keystroke} = vimEditor

  describe "exchange", ->

    it "swaps two words", ->
      set
        text: "Pass the salt and pepper!"
        cursor: [0, 0]
      ensure '2 w c x i w 2 w c x i w',
        text: "Pass the pepper and salt!", mode: "normal", cursor: [0, 18]

    it "clears selection", ->
      set
        text: "Pass the salt and pepper!"
        cursor: [0, 0]
      ensure '2 w c x i w c x c',
        text: "Pass the salt and pepper!", mode: "normal", cursor: [0, 9]
      ensure '2 w c x i w',
        text: "Pass the salt and pepper!", mode: "normal", cursor: [0, 18]
      ensure '2 b c x i w',
        text: "Pass the pepper and salt!", mode: "normal", cursor: [0, 9]

    it "supports the dot command", ->
      set
        text: "Pass the salt and pepper!"
        cursor: [0, 0]
      ensure '2 w c x i w',
        text: "Pass the salt and pepper!", mode: "normal", cursor: [0, 9]
      ensure '2 w .',
        text: "Pass the pepper and salt!", mode: "normal", cursor: [0, 18]

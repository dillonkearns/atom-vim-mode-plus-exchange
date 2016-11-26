requireFrom = (pack, path) ->
  packPath = atom.packages.resolvePackagePath(pack)
  require "#{packPath}/#{path}"

{getVimState} = requireFrom 'vim-mode-plus', 'spec/spec-helper'

describe "vim-mode-plus-exchange", ->
  [set, ensure, keystroke, editor, editorElement, vimState] = []

  beforeEach ->
    atom.keymaps.add "test",
      'atom-text-editor.vim-mode-plus.normal-mode':
        'x': 'vim-mode-plus-user:exchange'
      , 100

    # waitsForPromise ->
    #   atom.packages.activatePackage('vim-mode-plus-exchange')

    getVimState 'sample.txt', (state, vim) ->
      vimState = state
      {editor, editorElement} = state
      {set, ensure, keystroke} = vim

  describe "exchange", ->

    getEnsureRowText = (row, cursor) ->
      (_keystroke, rowText) ->
        keystroke _keystroke
        expect(editor.lineTextForBufferRow(row)).toBe rowText
        ensure cursor: cursor

    it "swaps two words", ->
      set cursor: (point = [1, 0])
      ensureRowText = getEnsureRowText(0, point)

      ensureRowText 'l', 'Pass the salt and pepper!'

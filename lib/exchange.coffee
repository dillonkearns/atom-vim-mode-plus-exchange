requireFrom = (pack, path) ->
  packPath = atom.packages.resolvePackagePath(pack)
  require "#{packPath}/lib/#{path}"

Base = requireFrom('vim-mode-plus', 'base')
Operator = Base.getClass('Operator')
class Exchange extends Operator
  @commandPrefix: 'vim-mode-plus-user'
  hover: icon: ':arrows_counterclockwise:', emoji: ':arrows_counterclockwise:'
  acceptPresetOccurrence: false
  requireTarget: true
  acceptPersistentSelection: false
  stayAtSamePosition: true

  mutateSelection: (selection) ->
    if @vimState.persistentSelection.getMarkerBufferRanges().length > 0
      other = @vimState.persistentSelection.getMarkerBufferRanges()[0]
      otherText = @editor.getTextInRange(other)
      selectionText = selection.getText()
      @editor.setTextInBufferRange(other, selectionText)
      selection.insertText(otherText)
      @vimState.clearPersistentSelections()
      @editorElement.classList.remove("exchange-pending")
    else
      @editorElement.classList.add("exchange-pending")
      @persistentSelection.markBufferRange(selection.getBufferRange())


class ExchangeLine extends Exchange
  wise: 'linewise'

  initialize: ->
    super()
    @target = 'MoveToRelativeLine' if @isMode('normal')
    if @isMode('visual', 'characterwise')
      @stayOnLinewise = false

module.exports = {Exchange, ExchangeLine}

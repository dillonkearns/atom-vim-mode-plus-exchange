"use babel"

module.exports = function loadVmpCommands(service) {
  class Exchange extends service.getClass("Operator") {
    static commandPrefix = "vim-mode-plus-user"
    acceptPresetOccurrence = false
    requireTarget = true
    acceptPersistentSelection = false
    stayAtSamePosition = true

    mutateSelection(selection) {
      if (this.vimState.persistentSelection.getMarkerBufferRanges().length > 0) {
        const other = this.vimState.persistentSelection.getMarkerBufferRanges()[0]
        const otherText = this.editor.getTextInRange(other)
        const selectionText = selection.getText()
        this.editor.setTextInBufferRange(other, selectionText)
        selection.insertText(otherText)
        this.vimState.clearPersistentSelections()
        this.editorElement.classList.remove("exchange-pending")
      } else {
        this.editorElement.classList.add("exchange-pending")
        this.persistentSelection.markBufferRange(selection.getBufferRange())
      }
    }
  }

  class ExchangeLine extends Exchange {
    wise = "linewise"

    initialize() {
      if (this.isMode("normal")) {
        this.target = "MoveToRelativeLine"
      } else if (this.isMode("visual", "characterwise")) {
        this.stayOnLinewise = false
      }
      return super.initialize()
    }
  }

  return {Exchange, ExchangeLine}
}

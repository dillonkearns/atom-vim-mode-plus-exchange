{CompositeDisposable} = require 'atom'

module.exports =
  activate: ->
    @subscriptions = new CompositeDisposable

  deactivate: ->
    @subscriptions?.dispose()
    @subscriptions = {}
    cachedTags = null

  subscribe: (args...) ->
    @subscriptions.add args...

  consumeVim: ->
    {Exchange, ExchangeLine} = require "./exchange"
    @subscribe(
      Exchange.registerCommand(),
      ExchangeLine.registerCommand()
    )

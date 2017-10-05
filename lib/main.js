const {CompositeDisposable} = require("atom")

module.exports = {
  activate() {
    this.subscriptions = new CompositeDisposable()
  },

  deactivate() {
    this.subscriptions.dispose()
  },

  consumeVim(service) {
    const {Exchange, ExchangeLine} = require("./exchange")(service)
    this.subscriptions.add(Exchange.registerCommand(), ExchangeLine.registerCommand())
  },
}

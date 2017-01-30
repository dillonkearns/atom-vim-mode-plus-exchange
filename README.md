# vim-mode-plus-exchange package

A port of Tom McDonald's [vim-exchange](https://github.com/tommcdo/vim-exchange).

![Exchange demo](https://raw.githubusercontent.com/dillonkearns/atom-vim-mode-plus-exchange/master/exchange-demo.gif)

*Note* Package requires [vim-mode-plus](https://atom.io/packages/vim-mode-plus)


`cx{motion}` sets the first area for the exchange (or initiates it once ). Notice that the `.` command can be used to mark a second area for the exchange using the same {motion} as the first.

![Exchange demo](https://raw.githubusercontent.com/dillonkearns/atom-vim-mode-plus-exchange/master/exchange-demo2.gif)

`cxx` marks a line to be exchanged. In visual-mode, `x` marks the selection to be exchanged.

`cxc` clears pending exchanges.


See these pages for more:
* [Swapping two regions of text with exchange.vim][e65]
* [vim-exchange](https://github.com/tommcdo/vim-exchange)

[e65]: http://vimcasts.org/episodes/swapping-two-regions-of-text-with-exchange-vim

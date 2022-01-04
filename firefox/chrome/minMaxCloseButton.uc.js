// ==UserScript==
// @name            MinMaxClose Button
// @author          xiaoxiaoflood
// @include         main
// @shutdown        UC.MinMaxCloseButton.destroy();
// @onlyonce
// ==/UserScript==

// inspired by: https://j.mozest.com/ucscript/script/83.meta.js

UC.MinMaxCloseButton = {
  init: function () {
    CustomizableUI.createWidget({
      id: 'minMaxClose-button',
      type: 'custom',
      defaultArea: CustomizableUI.AREA_NAVBAR,
      onBuild: function (doc) {
        let btn = _uc.createElement(doc, 'toolbarbutton', {
          id: 'minMaxClose-button',
          class: 'toolbarbutton-1 chromeclass-toolbar-additional',
          label: 'Window Button',
          tooltiptext: 'Left-Click: Minimize\nMiddle-Click: Maximize/Restore to fixed position\nShift + Middle-Click: Maximize/Restore to previous position\nRight-Click: Do nothing',
          image: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAO0lEQVQ4jWNgYGD4jwWTBCg2gBSDSTKcYgNwGUqRzfQzAJcYxQYQBahiAE0SF7pBVEn2VHEJ/VyANQwACylDvQ9eqkEAAAAASUVORK5CYII=',
          oncontextmenu: 'return false',
          onclick: 'UC.MinMaxCloseButton.BrowserManipulateCombine(event)'
        });

        return btn;
      }
    });
  },

  BrowserManipulateCombine: function (e) {
    let win = e.view;
    switch (e.button) {
      case 0:
        win.minimize();
        break;
      case 1:
        let max = win.document.getElementById('main-window').getAttribute('sizemode') == 'maximized' ? true : false;
        if ((!e.shiftKey && max) ||
            (e.shiftKey && !max && !(win.screenX === -5 && win.screenY === 0 && win.innerWidth === 1992 && win.innerHeight === 1056))) {
          win.resizeTo(1992, 1056);
          win.moveTo(-5, 0);
        } else if (max && e.shiftKey) {
          win.restore();
        } else {
          win.maximize();
        }
        break;
      case 2:
        // win.BrowserTryToCloseWindow();
        break;
    }
  },

  destroy: function () {
    CustomizableUI.destroyWidget('minMaxClose-button');
    delete UC.MinMaxCloseButton;
  }
}

UC.MinMaxCloseButton.init();

// Podmieniamy te 2 funkcje:
app_shop.run(
  () => {
    document.querySelectorAll('.footer_tab__header').forEach((tab) => {
      tab.addEventListener('click', (ev) => {
        const hideArrowAttr = tab.getAttribute('data-hide-arrow');
        if (hideArrowAttr === 'true') return;

        const tabContentID = tab.getAttribute('aria-controls');
        const contentElement = document.getElementById(tabContentID);
        const expandedAttr = tab.getAttribute('aria-expanded') === 'true';

        if (app_shop.vars.view < 2) {
          ev.preventDefault();
          tab.setAttribute('aria-expanded', !expandedAttr);
          tab.setAttribute('data-previous-state', !expandedAttr);
          contentElement.setAttribute('aria-hidden', expandedAttr);
        }
      });
    });
  },
  'all',
  '.footer_tab__header, .footer_links_sub',
);

app_shop.run(
  () => {
    document.querySelectorAll('#footer_links [aria-hidden]').forEach((tab) => {
      if (app_shop.vars.view === 1 && !(tab.hasAttribute('data-previous-state'))) {
        const previousState = tab.getAttribute('aria-hidden');
        tab.setAttribute('data-previous-state', previousState);
      }

      const prevState = tab.getAttribute('data-previous-state');
      tab.setAttribute('aria-hidden', prevState ?? false);
    });
  },
  [1, 2, 3, 4],
  '.footer_tab__header, .footer_links_sub',
);

// na te 3:
app_shop.run(() => {
  document.querySelectorAll('.footer_tab__header').forEach((tab) => {
    const tabContentID = tab.getAttribute('aria-controls');
    const contentElement = document.getElementById(tabContentID);
    if (!contentElement) return;

    const initialExpanded = tab.getAttribute('aria-expanded') === 'true';
    tab.setAttribute('data-previous-state', initialExpanded);

    tab.addEventListener('click', (ev) => {
      const hideArrowAttr = tab.getAttribute('data-hide-arrow');
      if (app_shop.vars.view > 1 || hideArrowAttr === 'true') return;
      ev.preventDefault();
      contentElement.classList.add('height-transition');
      const expandedAttr = tab.getAttribute('aria-expanded') !== 'true';
      tab.setAttribute('aria-expanded', expandedAttr);
      contentElement.setAttribute('aria-hidden', !expandedAttr);
      tab.setAttribute('data-previous-state', expandedAttr);
    });
  });
}, 'all', '.footer_tab__header, .footer_links_sub');

app_shop.run(() => {
  document.querySelectorAll('#footer_links .footer_tab__header').forEach((tab) => {
    const tabContentID = tab.getAttribute('aria-controls');
    const contentElement = document.getElementById(tabContentID);
    if (!contentElement) return;

    contentElement.classList.remove('height-transition');

    const state = tab.getAttribute('data-previous-state') === 'true';
    contentElement.setAttribute('aria-hidden', !state);
  });
}, [1], '.footer_tab__header, .footer_links_sub');

app_shop.run(() => {
  document.querySelectorAll('#footer_links [aria-hidden]').forEach((tab) => {
    tab.setAttribute('aria-hidden', false);
    tab.classList.remove('height-transition');
  });
}, [2, 3, 4], '.footer_tab__header, .footer_links_sub');

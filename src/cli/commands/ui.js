import { register } from '../router.js';
import * as core from '../../core/ui.js';

register('ui', {
  description: 'UI automation tools (hover, scroll, find, panel, fullscreen)',
  subcommands: new Map([
    ['hover', {
      description: 'Hover over a UI element',
      options: {
        by: { type: 'string', short: 'b', description: 'Selector: aria-label, data-name, text, class-contains' },
        value: { type: 'string', short: 'v', description: 'Value to match' },
      },
      handler: (opts) => core.hover({ by: opts.by || 'text', value: opts.value }),
    }],
    ['scroll', {
      description: 'Scroll the chart',
      options: {
        amount: { type: 'string', short: 'a', description: 'Scroll amount in pixels (default 300)' },
      },
      handler: (opts, positionals) => {
        const direction = positionals[0] || 'down';
        return core.scroll({ direction, amount: opts.amount ? Number(opts.amount) : undefined });
      },
    }],
    ['find', {
      description: 'Find UI elements by text, aria-label, or CSS selector',
      options: {
        strategy: { type: 'string', short: 's', description: 'Search strategy: text, aria-label, css' },
      },
      handler: (opts, positionals) => {
        if (!positionals[0]) throw new Error('Query required. Usage: tv ui find "Indicators"');
        return core.findElement({ query: positionals.join(' '), strategy: opts.strategy });
      },
    }],
    ['panel', {
      description: 'Open/close/toggle a panel',
      handler: (opts, positionals) => {
        if (!positionals[0]) throw new Error('Usage: tv ui panel pine-editor open');
        return core.openPanel({ panel: positionals[0], action: positionals[1] || 'toggle' });
      },
    }],
    ['fullscreen', {
      description: 'Toggle fullscreen mode',
      handler: () => core.fullscreen(),
    }],
  ]),
});

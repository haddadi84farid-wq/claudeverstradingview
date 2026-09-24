import { register } from '../router.js';
import * as core from '../../core/health.js';

register('status', {
  description: 'Check CDP connection to TradingView',
  handler: () => core.healthCheck(),
});

register('launch', {
  description: 'Launch TradingView with CDP enabled',
  options: {
    port: { type: 'string', short: 'p', description: 'CDP port (default 9222)' },
    kill: { type: 'boolean', description: 'Force-close running TradingView first (unsaved work is lost)' },
  },
  handler: (opts) => core.launch({
    port: opts.port ? Number(opts.port) : undefined,
    kill_existing: opts.kill === true,
  }),
});

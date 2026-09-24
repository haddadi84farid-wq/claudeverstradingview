import { z } from 'zod';
import { jsonResult } from './_format.js';
import * as core from '../core/capture.js';

export function registerCaptureTools(server) {
  server.tool('capture_screenshot', 'Take a screenshot of the TradingView chart', {
    region: z.enum(['full', 'chart', 'strategy_tester']).optional().describe('Region to capture: full, chart, strategy_tester (default full)'),
    filename: z.string().regex(/^[A-Za-z0-9_-]{1,64}$/).optional().describe('Custom filename without extension: letters, digits, - and _ only (max 64)'),
    method: z.string().optional().describe('Capture method: cdp (Page.captureScreenshot) or api (chartWidgetCollection.takeScreenshot) (default cdp)'),
  }, async ({ region, filename, method }) => {
    try { return jsonResult(await core.captureScreenshot({ region, filename, method })); }
    catch (err) { return jsonResult({ success: false, error: err.message }, true); }
  });
}

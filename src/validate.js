/**
 * Input validation helpers.
 * Every caller-supplied value that ends up inside JavaScript evaluated in the
 * TradingView page, or inside a file path, must pass through one of these.
 * Validated strings are still inserted with JSON.stringify (defense in depth).
 */

const SYMBOL_RE = /^[A-Za-z0-9:._!^-]{1,64}$/;          // BTCUSD, NYMEX:CL1!, BINANCE:BTCUSDT.P
const TIMEFRAME_RE = /^(\d{1,4}[SDWMH]?|[SDWM])$/i;      // 1, 15, 240, D, 1D, W, 1M, 15S
const ENTITY_ID_RE = /^[A-Za-z0-9_$.-]{1,64}$/;
const DATE_RE = /^\d{4}-\d{2}-\d{2}$/;                   // YYYY-MM-DD
const FILENAME_RE = /^[A-Za-z0-9_-]{1,64}$/;

export const SHAPES = ['horizontal_line', 'vertical_line', 'trend_line', 'rectangle', 'text'];

function check(re, value, name, expected) {
  if (typeof value !== 'string' || !re.test(value)) {
    throw new Error(`Invalid ${name}: ${JSON.stringify(value)}. Expected ${expected}.`);
  }
  return value;
}

export function symbol(value) {
  return check(SYMBOL_RE, value, 'symbol', 'letters, digits and : . _ ! ^ - (e.g. NASDAQ:AAPL)');
}

export function timeframe(value) {
  return check(TIMEFRAME_RE, value, 'timeframe', 'e.g. 1, 15, 60, 240, D, W, M');
}

export function entityId(value) {
  return check(ENTITY_ID_RE, value, 'entity_id', 'an ID returned by chart_get_state or draw_list');
}

export function date(value) {
  check(DATE_RE, value, 'date', 'YYYY-MM-DD');
  if (isNaN(Date.parse(value))) throw new Error(`Invalid date: ${JSON.stringify(value)}.`);
  return value;
}

export function filename(value) {
  return check(FILENAME_RE, value, 'filename', 'letters, digits, - and _ only (max 64 chars)');
}

export function shape(value) {
  if (!SHAPES.includes(value)) {
    throw new Error(`Invalid shape: ${JSON.stringify(value)}. Expected one of: ${SHAPES.join(', ')}.`);
  }
  return value;
}

export function finiteNumber(value, name) {
  const n = typeof value === 'number' ? value : (typeof value === 'string' && value.trim() !== '' ? Number(value) : NaN);
  if (!Number.isFinite(n)) throw new Error(`Invalid ${name}: ${JSON.stringify(value)}. Expected a number.`);
  return n;
}

export function text(value, name, maxLength = 200) {
  if (typeof value !== 'string' || value.length > maxLength) {
    throw new Error(`Invalid ${name}: expected a string of at most ${maxLength} characters.`);
  }
  return value;
}

/** Turn any string into something safe to use inside a file name. */
export function fileSafe(value) {
  return String(value).replace(/[^A-Za-z0-9_-]/g, '_').slice(0, 64);
}

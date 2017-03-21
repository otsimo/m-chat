const i18n = require('./i18n');
const en = require('./en.json');
const tr = require('./tr.json');
i18n.translations = { en, tr };
i18n.fallbacks = true;
export function setLocale(locale) {
  i18n.locale = locale;
}
export default i18n;
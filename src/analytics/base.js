export class BaseAnalytics {
  /**
   * start the analytics service
   * @param {string} env
   */
  start(env, appname) { }
  /**
   * Set User info to analytics service
   * @param {any} app 
   */
  setUserInfo(app) { }
  /**
   * send the event
   * @param {string} name 
   * @param {any} data 
   */
  event(name, data) { }
  /**
   * set current screen
   * @param {string} name 
   */
  screen(name) { }
}

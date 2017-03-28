import {
  GoogleAnalyticsTracker,
} from 'react-native-google-analytics-bridge';
import { BaseAnalytics } from './base';
export class GoogleAnalytics extends BaseAnalytics {
  /**
   * start the analytics service
   * @param {string} env
   */
  start(env) {
    if (env === 'production') {
      this.tracker = new GoogleAnalyticsTracker('');
    } else {
      this.tracker = null;
    }
  }
  /**
   * Set User info to analytics service
   * @param {any} app
   */
  setUserInfo(app) {
    if (this.tracker) {
      this.tracker.setUser(app.profileId);
    }
  }
  /**
   * send the event
   * @param {string} name
   * @param {any} data
   */
  event(name) {
    if (this.tracker) {
      // Google does not support custom payload
      this.tracker.trackEvent(name, name);
    }
  }
  /**
   * set current screen
   * @param {string} name
   */
  screen(name) {
    if (this.tracker) {
      this.tracker.trackScreenView(name);
    }
  }
}

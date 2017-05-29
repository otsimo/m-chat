import React, { Component } from 'react';
import { View } from 'react-native';
import i18n from '../i18n';
import * as analytics from '../analytics';
import { ConsentPrefab } from './consentPrefab';
import * as utils from '../util';

export class ConsentStudySurvey extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };

  onNextPressed() {
    analytics.screen('Study Survey (consent)');
    analytics.event('Next clicked on ConsentStudySurvey');
    utils.navigateTo(this, 'ConsentPotentialBen');

  }

  renderTR() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={'file:///android_asset/webviews/consent5LearnMoreTR.html'} image={require("../../pngs/study_surveykopya.png")} textHeader={i18n.t('studySurvey.header')} text={i18n.t('studySurvey.text')} />
      </View>
    );
  }

  renderEN() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={'file:///android_asset/webviews/consent5LearnMoreEN.html'} image={require("../../pngs/study_surveykopya.png")} textHeader={i18n.t('studySurvey.header')} text={i18n.t('studySurvey.text')} />
      </View>
    );
  }
  render() {
    if (i18n.t('yes') === 'Yes') {
      return this.renderEN();
    } else {
      return this.renderTR();
    }
  }
}

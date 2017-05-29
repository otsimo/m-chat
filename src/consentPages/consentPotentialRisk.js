import React, { Component } from 'react';
import { View } from 'react-native';
import i18n from '../i18n';
import * as analytics from '../analytics';
import { ConsentPrefab } from './consentPrefab';
import * as utils from '../util';

export class ConsentPotentialRisk extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };

  onNextPressed() {
    analytics.screen('Potential Risks(consent)');
    analytics.event('Next clicked on ConsentPotentialRisk');
    utils.navigateTo(this, 'ConsentMedical');

  }


  renderTR() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={'file:///android_asset/webviews/consent7LearnMoreTR.html'} image={require("../../pngs/potential_riskkopya.png")} textHeader={i18n.t('potentialRisks.header')} text={i18n.t('potentialRisks.text')} />
      </View>
    );
  }

  renderEN() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={'file:///android_asset/webviews/consent7LearnMoreEN.html'} image={require("../../pngs/potential_riskkopya.png")} textHeader={i18n.t('potentialRisks.header')} text={i18n.t('potentialRisks.text')} />
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

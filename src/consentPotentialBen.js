import React, { Component } from 'react';
import { View, Text } from 'react-native';
import i18n from './i18n';
import * as analytics from './analytics';
import { ConsentPrefab } from './consentPrefab';

export class ConsentPotentialBen extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };
  onNextPressed() {
    analytics.screen('Potential Benefits(consent)');
    analytics.event('Next clicked');
    const { navigate } = this.props.navigation;
    navigate('ConsentPotentialRisk');
  }

  renderTR() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={'file:///android_asset/webviews/consent6LearnMoreTR.html'} image={require("../pngs/potential_benefitskopya.png")} textHeader={i18n.t('potentialBenefits.header')} text={i18n.t('potentialBenefits.text')} />
      </View>
    );
  }

  renderEN() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={'file:///android_asset/webviews/consent6LearnMoreEN.html'} image={require("../pngs/potential_benefitskopya.png")} textHeader={i18n.t('potentialBenefits.header')} text={i18n.t('potentialBenefits.text')} />
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

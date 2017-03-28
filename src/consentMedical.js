import React, { Component } from 'react';
import { View, Text } from 'react-native';
import i18n from './i18n';
import * as analytics from './analytics';
import { ConsentPrefab } from './consentPrefab';

export class ConsentMedical extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };

  onNextPressed() {
    analytics.screen('Not Medical(consent)');
    analytics.event('Next clicked');
    const { navigate } = this.props.navigation;
    navigate('ConsentFollowUp');
  }

  renderTR() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={'file:///android_asset/webviews/consent8LearnMoreTR.html'} image={require("../pngs/not_medicalkopya.png")} textHeader={i18n.t('notMedicalCare.header')} text={i18n.t('notMedicalCare.text')} />
      </View>
    );
  }

  renderEN() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={'file:///android_asset/webviews/consent8LearnMoreEN.html'} image={require("../pngs/not_medicalkopya.png")} textHeader={i18n.t('notMedicalCare.header')} text={i18n.t('notMedicalCare.text')} />
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

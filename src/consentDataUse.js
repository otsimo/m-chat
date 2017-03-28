import React, { Component } from 'react';
import { View, Text } from 'react-native';
import i18n from './i18n';
import * as analytics from './analytics';
import { ConsentPrefab } from './consentPrefab';

export class ConsentDataUse extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };

  onNextPressed() {
    analytics.screen('Data use(consent)');
    analytics.event('Next clicked');
    const { navigate } = this.props.navigation;
    navigate('ConsentStudySurvey');
  }

  renderTR() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={'file:///android_asset/webviews/consent4LearnMoreTR.html'} image={require("../pngs/data_usekopya.png")} textHeader={i18n.t('dataUse.header')} text={i18n.t('dataUse.text')} />
      </View>
    );
  }

  renderEN() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={'file:///android_asset/webviews/consent4LearnMoreEN.html'} image={require("../pngs/data_usekopya.png")} textHeader={i18n.t('dataUse.header')} text={i18n.t('dataUse.text')} />
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

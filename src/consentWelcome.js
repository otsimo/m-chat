import React, { Component } from 'react';
import { View, Text } from 'react-native';
import i18n from './i18n';
import * as analytics from './analytics';
import { ConsentPrefab } from './consentPrefab';

export class ConsentWelcome extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };

  onNextPressed() {
    analytics.screen('Welcome (consent)');
    analytics.event('Next clicked');
    const { navigate } = this.props.navigation;
    navigate('ConsentDataGather');
  }

  renderTR() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={'file:///android_asset/webviews/consent1LearnMoreTR.html'} textHeader={i18n.t('welcome.header')} text={i18n.t('welcome.text')} />
      </View>
    );
  }
  renderEN() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={'file:///android_asset/webviews/consent1LearnMoreEN.html'} textHeader={i18n.t('welcome.header')} text={i18n.t('welcome.text')} />
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

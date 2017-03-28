import React, { Component } from 'react';
import { View, Text } from 'react-native';
import i18n from './i18n';
import * as analytics from './analytics';
import { ConsentPrefab } from './consentPrefab';

export class ConsentPrivacy extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };

  onNextPressed() {
    analytics.screen('Privacy (consent)');
    analytics.event('Next clicked');
    const { navigate } = this.props.navigation;
    navigate('ConsentDataUse');
  }

  renderTR() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={'file:///android_asset/webviews/consent3LearnMoreTR.html'} image={require("../pngs/privacykopya.png")} textHeader={i18n.t('privacy.header')} text={i18n.t('privacy.text')} />
      </View>
    );
  }

  renderEN() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={'file:///android_asset/webviews/consent3LearnMoreEN.html'} image={require("../pngs/privacykopya.png")} textHeader={i18n.t('privacy.header')} text={i18n.t('privacy.text')} />
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

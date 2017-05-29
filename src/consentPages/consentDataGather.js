import React, { Component } from 'react';
import { View } from 'react-native';
import i18n from '../i18n';
import * as analytics from '../analytics';
import { ConsentPrefab } from './consentPrefab';
import * as utils from '../util';

export class ConsentDataGather extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };

  onNextPressed() {
    analytics.screen('Data gather(consent)');
    analytics.event('Next clicked on ConsentDataGather');
    utils.navigateTo(this,'ConsentPrivacy');
  }

  renderTR() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab learnURL={'file:///android_asset/webviews/consent2LearnMoreTR.html'} image={require("../../pngs/data_gatherkopya.png")} onPress={() => this.onNextPressed()} textHeader={i18n.t('dataGather.header')} text={i18n.t('dataGather.text')} />
      </View>
    );
  }

  renderEN() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab learnURL={'file:///android_asset/webviews/consent2LearnMoreEN.html'} image={require("../../pngs/data_gatherkopya.png")} onPress={() => this.onNextPressed()} textHeader={i18n.t('dataGather.header')} text={i18n.t('dataGather.text')} />
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

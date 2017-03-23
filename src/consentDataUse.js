import React, { Component } from 'react';
import { View, Text } from 'react-native';
import i18n from './i18n';
import { ConsentPrefab } from './consentPrefab';

export class ConsentDataUse extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };

  onNextPressed() {
    const { navigate } = this.props.navigation;
    navigate('ConsentStudySurvey');
  }

  render() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={require('../webviews/consent4LearnMore.html')} image={require("../pngs/data_usekopya.png")} textHeader={i18n.t('dataUse.header')} text={i18n.t('dataUse.text')} />
      </View>
    );
  }
}

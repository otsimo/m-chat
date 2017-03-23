import React, { Component } from 'react';
import { View, Text } from 'react-native';
import i18n from './i18n';
import { ConsentPrefab } from './consentPrefab';

export class ConsentPotentialRisk extends Component {
   static navigationOptions = {
    header: ({
      visible: true,
    }),
  };

onNextPressed() {
  const { navigate } = this.props.navigation;
  navigate('ConsentMedical');
}

  render() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={require('../webviews/consent7LearnMore.html')} image={require("../pngs/potential_riskkopya.png")} textHeader={i18n.t('potentialRisks.header')} text={i18n.t('potentialRisks.text')} />
      </View>
    );
  }
}

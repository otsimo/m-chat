import React, { Component } from 'react';
import { View, Text } from 'react-native';
import i18n from './i18n';
import { ConsentPrefab } from './consentPrefab';

export class ConsentStudySurvey extends Component {
   static navigationOptions = {
    header: ({
      visible: true,
    }),
  };

onNextPressed() {
  const { navigate } = this.props.navigation;
  navigate('ConsentPotentialBen');
}

  render() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={require('../webviews/consent5LearnMore.html')} image={require("../pngs/study_surveykopya.png")} textHeader={i18n.t('studySurvey.header')} text={i18n.t('studySurvey.text')} />
      </View>
    );
  }
}

import React, { Component } from 'react';
import { View, Text } from 'react-native';
import i18n from './i18n';
import { ConsentPrefab } from './consentPrefab';

export class ConsentDataUse extends Component {
  static navigationOptions = {
    header: ({
      visible: false,
    }),
  };

onNextPressed() {
  const { navigate } = this.props.navigation;
  navigate('ConsentStudySurvey');
}

  render() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} textHeader="Data Using" text=""/>
      </View>
    );
  }
}

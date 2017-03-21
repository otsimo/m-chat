import React, { Component } from 'react';
import { View, Text } from 'react-native';
import i18n from './i18n';
import { ConsentPrefab } from './consentPrefab';

export class ConsentMedical extends Component {
   static navigationOptions = {
    header: ({
      visible: true,
    }),
  };

onNextPressed() {
  const { navigate } = this.props.navigation;
  navigate('ConsentFollowUp');
}

  render() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} image={require("../pngs/not_medicalkopya.png")} textHeader="Not Medical Care" text=""/>
      </View>
    );
  }
}

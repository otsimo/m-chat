import React, { Component } from 'react';
import { View, Text } from 'react-native';
import i18n from './i18n';
import { ConsentPrefab } from './consentPrefab';

export class ConsentPrivacy extends Component {
  static navigationOptions = {
    header: ({
      visible: false,
    }),
  };

onNextPressed() {
  const { navigate } = this.props.navigation;
  navigate('ConsentDataUse');
}

  render() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} textHeader="Privacy" text=""/>
      </View>
    );
  }
}

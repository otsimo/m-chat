import React, { Component } from 'react';
import { View, Text } from 'react-native';
import i18n from './i18n';
import { ConsentPrefab } from './consentPrefab';

export class ConsentFollowUp extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };

  onNextPressed() {
    const { navigate } = this.props.navigation;
    navigate('EligibilityRelation');
  }

  render() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab onPress={() => this.onNextPressed()} learnURL={require('../webviews/consent9LearnMore.html')} image={require("../pngs/follow_upkopya.png")} textHeader={i18n.t('followUp.header')} text={i18n.t('followUp.text')} />
      </View>
    );
  }
}

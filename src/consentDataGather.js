import React, { Component } from 'react';
import { View, Text } from 'react-native';
import i18n from './i18n';
import { ConsentPrefab } from './consentPrefab';

export class ConsentDataGather extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };

  onNextPressed() {
    const { navigate } = this.props.navigation;
    navigate('ConsentPrivacy');
  }

  render() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center' }}>
        <ConsentPrefab learnURL={require('../webviews/consent2LearnMore.html')} image={require("../pngs/data_gatherkopya.png")} onPress={() => this.onNextPressed()} textHeader={i18n.t('dataGather.header')} text={i18n.t('dataGather.text')} />
      </View>
    );
  }
}

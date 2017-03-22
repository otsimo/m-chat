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
        <ConsentPrefab learnURL={'https://github.com/facebook/react-native'} image={require("../pngs/data_gatherkopya.png")} onPress={() => this.onNextPressed()} textHeader="Data Gathering" text="Break a long consent document into easily digestible subsections. Each subsection can cover one aspect of the study, such as data gathering, data use, potential benefits."/>
      </View>
    );
  }
}

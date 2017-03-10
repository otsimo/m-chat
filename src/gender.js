import React, { Component } from 'react';
import {
  View,
  Button,
  Text,
} from 'react-native';
import { StackNavigator } from 'react-navigation';
import { MChat } from './app';
import { resetTo } from './util';

export class Gender extends Component {
  static navigationOptions = {
    title: 'Gender',
  };
  render() {
    const { params } = this.props.navigation.state;
    return (
      <View
        style={{
          backgroundColor: 'rgb(247,247,247)',
          justifyContent: 'center',
          alignItems: 'center',
        }}
      >
        <Text>
          {params.genderText}
        </Text>
        <Button
          onPress={() => resetTo(this, 'app')}
          title="Male"
        />
        <Button
          onPress={() => resetTo(this, 'app')}
          title="Female"
        />
      </View>
    );
  }
}
const SimpleApp = StackNavigator({
  app: { screen: MChat },
});

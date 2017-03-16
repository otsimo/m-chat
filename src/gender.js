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
    return (
      <View
        style={{
          backgroundColor: 'rgb(247,247,247)',
          justifyContent: 'center',
          alignItems: 'center',
        }}
      >
        <Text> fs</Text>
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

import React, { Component } from 'react';
import {
  View,
  Button,
  TouchableOpacity,
  Modal,
  Text,
  TouchableWithoutFeedback,
  BackAndroid,
} from 'react-native';

export class ModalButton extends Component {

  buttonPressed() {
    this.props.onPress();
  }
  render() {
    return (
      <View>
        <TouchableOpacity onPress={() => this.buttonPressed()} >
        <View
          style={{
            margin: 10,
            
            justifyContent: 'flex-end',
            alignItems: 'flex-start',
          }}
        >
          <Text style={{ color: 'black', fontSize: 18 }} >{this.props.name}</Text>
        
        </View>
      </TouchableOpacity>
      </View>
    );
  }
}
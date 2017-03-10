import React, { Component } from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';


export class CustomizedButton extends Component {

  static propTypes = {
    onClick: React.PropTypes.func.isRequired,
    buttonName: React.PropTypes.string.isRequired,
    // isSelected: React.PropTypes.bool.isRequired,
  }

  state = { pressStatus: false };

  buttonPressed() {
    this.props.onClick();
  }

  render() {
    return (
      <TouchableOpacity onPress={() => this.buttonPressed()} >
        <View
          style={{
            margin: 10,
            padding: 5,
            justifyContent: 'center',
            alignItems: 'center',
          }}
        >
          <Text style={{ color: this.props.isSelected ? 'rgb( 165, 90,239)' : 'black', fontSize: 26 }} >{this.props.buttonName}</Text>
        
        </View>
      </TouchableOpacity>
    );
  }
}

const styles = StyleSheet.create({
  bottomLine: {
    position: 'absolute',
    left: 0,
    right: 0,
    height: 2,
    bottom: 0,
  },
});

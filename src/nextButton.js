import React, { Component } from 'react';
import { View, Text, TouchableOpacity } from 'react-native';

export class NextButton extends Component {
  static propTypes = {
    onClick: React.PropTypes.func.isRequired,
  }

  render() {
    return (
      <TouchableOpacity onPress={() => this.props.onClick()} >
        <View
          style={{
            flexDirection: 'column',
            padding: 20,
            margin: 0,
            marginBottom: 15,
            justifyContent: 'center',
            alignItems: 'center',
            backgroundColor: this.props.enabled ? 'rgb(0,169,250)' : 'rgb(231,231,231)',
          }}
        >
          <Text style={{ color: 'white' }}>NEXT</Text>
        </View>
      </TouchableOpacity>
    );
  }
}

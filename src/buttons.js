import React, { Component } from 'react';
import { View, Text } from 'react-native';
import { CustomizedButton } from './customizedButton.js';
import i18n from './i18n';

export class Buttons extends Component {
  static propTypes = {
    selectionChanged: React.PropTypes.func.isRequired,
    onclick: React.PropTypes.func.isRequired,
  }

  state = {
    selectedOne: '',
    showNext: '',
  }

  selectButton(name) {
    this.setState({ selectedOne: name });
    this.props.selectionChanged(name);
    this.props.onclick(name);
  }

  render() {
    return (
      <View
        style={{
          flexDirection: 'row',
          margin: 0,
          justifyContent: 'center',
          alignItems: 'center',
        }}
      >
        <CustomizedButton isSelected={this.state.selectedOne === 'yes'} buttonName={i18n.t('yes')} onClick={() => this.selectButton('yes')} />
        <Text> | </Text>
        <CustomizedButton isSelected={this.state.selectedOne === 'no'} buttonName={i18n.t('no')} onClick={() => this.selectButton('no')} />
      </View>
    );
  }
}

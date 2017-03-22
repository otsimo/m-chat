import React, { Component } from 'react';
import { View, Text } from 'react-native';
import { CustomizedButton } from './customizedButton.js';
import i18n from './i18n';

export class GenderButton extends Component {
  static propTypes = {
    selectionChanged: React.PropTypes.func.isRequired,
  }

  state = {
    selectedOne: '',
    showNext: '',
  }

  selectButton(name) {
    this.setState({ selectedOne: name });
    this.props.selectionChanged(name);
  }

  render() {
    return (
      <View
        style={{
          flexDirection: 'column',
          justifyContent: 'center',
          alignItems: 'center',
        }}
      >
        <CustomizedButton isSelected={this.state.selectedOne === 'male'} buttonName={i18n.t('male')} onClick={() => this.selectButton('male')} />
        <CustomizedButton isSelected={this.state.selectedOne === 'female'} buttonName={i18n.t('female')} onClick={() => this.selectButton('female')} />
      </View>
    );
  }
}

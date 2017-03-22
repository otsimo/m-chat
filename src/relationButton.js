import React, { Component } from 'react';
import { View, Text } from 'react-native';
import { CustomizedButton } from './customizedButton.js';
import i18n from './i18n';

export class RelationButton extends Component {
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
        <CustomizedButton isSelected={this.state.selectedOne === 'yes'} buttonName={i18n.t('yes')} onClick={() => this.selectButton('yes')} />
        <CustomizedButton isSelected={this.state.selectedOne === 'ye'} buttonName={i18n.t('yes')} onClick={() => this.selectButton('ye')} />
        <CustomizedButton isSelected={this.state.selectedOne === 'n'} buttonName={i18n.t('yes')} onClick={() => this.selectButton('n')} />
        <CustomizedButton isSelected={this.state.selectedOne === 'no'} buttonName={i18n.t('no')} onClick={() => this.selectButton('no')} />
      </View>
    );
  }
}

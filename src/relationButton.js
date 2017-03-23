import React, { Component } from 'react';
import { View, Text } from 'react-native';
import { RelationCustomizedButton } from './relationCustomizedButton';
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
        <RelationCustomizedButton isSelected={this.state.selectedOne === 'parent'} buttonName={i18n.t('parent')} onClick={() => this.selectButton('parent')} />
        <RelationCustomizedButton isSelected={this.state.selectedOne === 'grandparent'} buttonName={i18n.t('grandparent')} onClick={() => this.selectButton('grandparent')} />
        <RelationCustomizedButton isSelected={this.state.selectedOne === 'guardion'} buttonName={i18n.t('guardion')} onClick={() => this.selectButton('guardion')} />
        <RelationCustomizedButton isSelected={this.state.selectedOne === 'educator'} buttonName={i18n.t('educator')} onClick={() => this.selectButton('educator')} />
        <RelationCustomizedButton isSelected={this.state.selectedOne === 'healthcare'} buttonName={i18n.t('healthcare')} onClick={() => this.selectButton('healthcare')} />
        <RelationCustomizedButton isSelected={this.state.selectedOne === 'other'} buttonName={i18n.t('other')} onClick={() => this.selectButton('other')} />
      </View>
    );
  }
}

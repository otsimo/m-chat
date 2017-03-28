import React, { Component } from 'react';
import { View, Text, TouchableOpacity, AsyncStorage } from 'react-native';
import i18n from './i18n';
import * as analytics from './analytics';
import { ConsentPrefab } from './consentPrefab';
import { RelationButton } from './relationButton';

export class EligibilityRelation extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };
  constructor(props) {
    super(props);
    this.relation = false;
  }

  state = {
    showNext: false,
  }
  getRelation(rel) {
    this.relation = rel;
    if (this.state.showNext === false) {
      this.setState({ showNext: true });
    }
  }

  async saveRel() {
    const saveData = {
      relation: this.relation,
    };
    await AsyncStorage.setItem('relation', JSON.stringify(saveData));
    // console.warn('rel', await AsyncStorage.getItem('relation'));
    if (this.relation !== false) {
      analytics.screen('Relation (eligibility)');
      analytics.event('Next clicked');
      const { navigate } = this.props.navigation;
      navigate('EligibilityGender');
    }
  }

  async pass() {
    const saveData = {
      relation: '',
    };
    await AsyncStorage.setItem('relation', JSON.stringify(saveData));
    // console.warn('rel', await AsyncStorage.getItem('relation'));

    analytics.screen('Relation (eligibility)');
    analytics.event('Pass clicked');
    const { navigate } = this.props.navigation;
    navigate('EligibilityGender');

  }

  render() {
    return (
      <View style={{ flex: 0.8, flexDirection: 'column', justifyContent: 'center', backgroundColor: 'white' }}>
        <View style={{ flex: 3, flexDirection: 'column', justifyContent: 'center', alignItems: 'center', backgroundColor: 'white' }}>
          <Text style={{ color: 'black', fontSize: 36 }}>
            {i18n.t('relation')}
          </Text>
        </View>

        <View style={{ flex: 6, flexDirection: 'column' }}>
          <RelationButton selectionChanged={rel => this.getRelation(rel)} />
        </View>

        <View style={{ flex: 1.5, flexDirection: 'column', justifyContent: 'center', alignItems: 'center', justifyContent: 'flex-start' }}>
          <TouchableOpacity onPress={() => this.pass()} >
            <Text style={{ color: 'black', fontSize: 15 }}>
              {i18n.t('pass')}
            </Text>
          </TouchableOpacity>
        </View>
        <View style={{ flex: 1, flexDirection: 'column' }}>
          <TouchableOpacity onPress={() => this.saveRel()} style={{ flex: 1, backgroundColor: this.state.showNext ? '#00a9fa' : '#e7e7e7', justifyContent: 'center' }}>
            <View>
              <Text style={{ color: 'white', fontSize: 26, textAlign: 'center' }}>
                {i18n.t('next')}
              </Text>
            </View>
          </TouchableOpacity>
        </View>
      </View>
    );
  }
}

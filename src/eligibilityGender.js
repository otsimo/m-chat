import React, { Component } from 'react';
import { View, Text, TouchableOpacity, AsyncStorage } from 'react-native';
import i18n from './i18n';
import { ConsentPrefab } from './consentPrefab';
import { GenderButton } from './genderButton';

export class EligibilityGender extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };
  constructor(props) {
    super(props);
    this.gender = false;
  }

  state = {
    showNext: false,
  }
  getGender(gen) {
    this.gender = gen;
    if (this.state.showNext === false) {
      this.setState({ showNext: true });
    }
  }

  async saveGen() {
    const saveData = {
      gender: this.gender,
    };
    await AsyncStorage.setItem('gender', JSON.stringify(saveData));
    // console.warn('rel', await AsyncStorage.getItem('relation'));
    if (this.gender !== false) {
      const { navigate } = this.props.navigation;
      navigate('EligibilityBday');
    }
  }

  async pass() {
    const saveData = {
      gender: '',
    };
    await AsyncStorage.setItem('gender', JSON.stringify(saveData));
    // console.warn('rel', await AsyncStorage.getItem('relation'));

    const { navigate } = this.props.navigation;
    navigate('EligibilityBday');
  }

  render() {
    return (
      <View style={{ flex: 0.8, flexDirection: 'column', justifyContent: 'center', backgroundColor: 'white' }}>
        <View style={{ flex: 3, flexDirection: 'column', justifyContent: 'center', alignItems: 'center', backgroundColor: 'white' }}>
          <Text style={{ color: 'black', fontSize: 36 }}>
            Gender ?
            </Text>
        </View>

        <View style={{ flex: 6, flexDirection: 'column' }}>
          <GenderButton selectionChanged={gen => this.getGender(gen)} />
        </View>

        <View style={{ flex: 1.5, flexDirection: 'column', alignItems: 'center', justifyContent: 'flex-start' }}>
          <TouchableOpacity onPress={() => this.pass()} >
            <Text style={{ color: 'black', fontSize: 15 }}>
              {i18n.t('pass')}
            </Text>
          </TouchableOpacity>
        </View>
        <View style={{ flex: 1, flexDirection: 'column' }}>
          <TouchableOpacity onPress={() => this.saveGen()} style={{ flex: 1, backgroundColor: this.state.showNext ? '#00a9fa' : '#e7e7e7', justifyContent: 'center' }}>
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

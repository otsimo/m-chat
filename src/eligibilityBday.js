import React, { Component } from 'react';
import { View, Text, TouchableOpacity, AsyncStorage, DatePickerAndroid } from 'react-native';
import i18n from './i18n';
import { ConsentPrefab } from './consentPrefab';
import { RelationButton } from './relationButton';

export class EligibilityBday extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };
  constructor(props) {
    super(props);
    this.birthDay = false;
    this.date = new Date();
  }

  state = {
    showNext: false,
    showDate: '',
  }

  getBday(bDay) {
    this.birthDay = bDay;
    if (this.state.showNext === false) {
      this.setState({ showNext: true });
    }
  }

  async saveBday() {
    const saveData = {
      Bday: this.date.getTime(),
    };
    await AsyncStorage.setItem('birthDay', JSON.stringify(saveData));
    // console.warn('rel', await AsyncStorage.getItem('relation'));
    if (this.birthDay !== false) {
      const { navigate } = this.props.navigation;
      navigate('EligibilityGender');
    }
  }

  async showPicker() {
    this.setState({ showNext: true });
    try {
      const {action, year, month, day} = await DatePickerAndroid.open({
        date: new Date(),
      });
      if (action !== DatePickerAndroid.dismissedAction) {
        // Selected year, month (0-11), day
        this.date = new Date(year, month, day);
        this.setState({ showDate: '' });
      }
    } catch ({code, message}) {
      console.warn('Cannot open date picker', message);
    }
  }
  async pass() {
    const saveData = {
      Bday: 0,
    };
    await AsyncStorage.setItem('birthDay', JSON.stringify(saveData));
    // console.warn('rel', await AsyncStorage.getItem('relation'));

    const { navigate } = this.props.navigation;
    navigate('EligibilityGender');

  }

  render() {
    return (
      <View style={{ flex: 0.8, flexDirection: 'column', justifyContent: 'center', backgroundColor: 'white' }}>
        <View style={{ flex: 3, flexDirection: 'column', justifyContent: 'center', alignItems: 'center', backgroundColor: 'white' }}>
          <Text style={{ color: 'black', fontSize: 36 }}>
            Birthday
            </Text>
        </View>

        <View style={{ flex: 6, flexDirection: 'row', justifyContent: 'center', padding: 20 }}>
          <TouchableOpacity onPress={() => this.showPicker()}>
            <View style={{ flexDirection: 'row', justifyContent: 'center' }} >

              <Text style={{ fontSize: 36 }}>
                {this.date.getDate()}
              </Text>
              <Text style={{ fontSize: 36 }}>
                {"-"}
              </Text>
              <Text style={{ fontSize: 36 }}>
                {this.date.getMonth() + 1}
              </Text>
              <Text style={{ fontSize: 36 }}>
                {"-"}
              </Text>
              <Text style={{ fontSize: 36 }}>
                {this.date.getFullYear()}
              </Text>
            </View>
          </TouchableOpacity>
        </View>

        <View style={{ flex: 0.5, flexDirection: 'column', justifyContent: 'center', alignItems: 'center' }}>
          <TouchableOpacity onPress={() => this.pass()} >
            <Text style={{ color: 'black', fontSize: 15 }}>
              {i18n.t('pass')}
            </Text>
          </TouchableOpacity>
        </View>
        <View style={{ flex: 1, flexDirection: 'column' }}>
          <TouchableOpacity onPress={() => this.saveBday()} style={{ flex: 1, backgroundColor: this.state.showNext ? '#00a9fa' : '#e7e7e7', justifyContent: 'center' }}>
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

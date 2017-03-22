import React, { Component } from 'react';
import { View, Text, TouchableOpacity, AsyncStorage, DatePickerAndroid } from 'react-native';
import i18n from './i18n';
import { ConsentPrefab } from './consentPrefab';
import { RelationButton } from './relationButton';
import { resetTo } from './util';
import { Logic } from './logic';

import q1 from '../questions/q1.json';
import q2 from '../questions/q2.json';
import q3 from '../questions/q3.json';
import q4 from '../questions/q4.json';
import q5 from '../questions/q5.json';
import q6 from '../questions/q6.json';
import q7 from '../questions/q7.json';
import q8 from '../questions/q8.json';

export class EligibilityBday extends Component {
  static navigationOptions = {
    header: ({
      visible: true,
    }),
  };

  constructor(props) {
    super(props);
    this.birthDay = true;
    this.date = new Date();
    this.logic = new Logic([q1, q2, q3]);
  }


  async dataOk() {
    try {
      const ok = await this.logic.haveDataOnDisk();
      this.setState({ ok });
    } catch (error) {
      console.error(error);
    }
  }

  componentDidMount() {
    this.dataOk();
  }

  async loadSurvey() {
    const ok = await this.logic.haveDataOnDisk();
    if (ok) {
      const a = await this.logic.loadState();
      this.logic.startSurveyTimers();
      resetTo(this, 'app', { logic: this.logic, id: '', start: true });
    } else {
      this.startSurvey();
    }
  }

  startSurvey() {
    this.logic.startSurveyTimers();
    resetTo(this, 'app', { logic: this.logic });
  }


  state = {
    showNext: false,
    showDate: '',
    ok: false,
  }


  isEligible() {
    const now = new Date();
    const sub = new Date(this.date.getTime() - now.getTime());
    if (sub < 41472000000) {
      return false;
    } else if (sub > 77760000000) {
      return false;
    } else {
      return true;
    }
  }

  async saveBday() {

    if (this.birthDay !== false) {
      if (this.isEligible()) {
        console.log('ok');
        const saveData = {
          Bday: this.date.getTime(),
        };
        await AsyncStorage.setItem('birthDay', JSON.stringify(saveData));
        // console.warn('rel', await AsyncStorage.getItem('relation'));

        
        this.loadSurvey();
      } else {
        const { navigate } = this.props.navigation;
        navigate('EligibilityNotFit');
      }
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
        this.birthDay = this.date;
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

    this.loadSurvey();

  }

  render() {
    return (
      <View style={{ flex: 0.8, flexDirection: 'column', justifyContent: 'center', backgroundColor: 'white' }}>
        <View style={{ flex: 3, flexDirection: 'column', justifyContent: 'center', alignItems: 'center', backgroundColor: 'white' }}>
          <Text style={{ color: 'black', fontSize: 36 }}>
            Birthday
            </Text>
        </View>

        <View style={{ flex: 6, flexDirection: 'row', justifyContent: 'center' }}>
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

        <View style={{ flex: 1.5, flexDirection: 'column', justifyContent: 'center', alignItems: 'center', justifyContent: 'flex-start' }}>
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

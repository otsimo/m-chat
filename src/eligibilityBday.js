import React, { Component } from 'react';
import { View, Text, TouchableOpacity, AsyncStorage, DatePickerAndroid } from 'react-native';
import i18n from './i18n';
import { ConsentPrefab } from './consentPrefab';
import { RelationButton } from './relationButton';
import { resetTo } from './util';
import { Logic } from './logic';
let moment = require('moment');

import q1 from '../questionsSimple/q1.json';
import q2 from '../questionsSimple/q2.json';
import q3 from '../questionsSimple/q3.json';
import q4 from '../questionsSimple/q4.json';
import q5 from '../questionsSimple/q5.json';
import q6 from '../questionsSimple/q6.json';
import q7 from '../questionsSimple/q7.json';
import q8 from '../questionsSimple/q8.json';
import q9 from '../questionsSimple/q9.json';
import q10 from '../questionsSimple/q10.json';
import q11 from '../questionsSimple/q11.json';
import q12 from '../questionsSimple/q12.json';
import q13 from '../questionsSimple/q13.json';
import q14 from '../questionsSimple/q14.json';
import q15 from '../questionsSimple/q15.json';
import q16 from '../questionsSimple/q16.json';
import q17 from '../questionsSimple/q17.json';
import q18 from '../questionsSimple/q18.json';
import q19 from '../questionsSimple/q19.json';
import q20 from '../questionsSimple/q20.json';
import q21 from '../questionsSimple/q21.json';
import q22 from '../questionsSimple/q22.json';
import q23 from '../questionsSimple/q23.json';


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
    this.logic = new Logic([q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23]);
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
    resetTo(this, 'app', { logic: this.logic, id: '' });
  }


  state = {
    showNext: false,
    showDate: '',
    ok: false,
  }


  isEligible() {
    const startTime = moment(new Date());
    const endTime = moment(this.date);
    const monts = startTime.diff(endTime, 'months');
    if (monts > 30) {
      return false;
    } else if (monts < 16) {
      return false;
    }
    return true;
  }

  async saveBday() {
    if (this.state.showNext) {
      if (this.birthDay !== false) {
        if (this.isEligible()) {
          const saveData = {
            Bday: this.date.getTime(),
          };
          try {
            await AsyncStorage.setItem('birthDay', JSON.stringify(saveData));
          } catch (err) {
            console.log('unable to save birthDay', err);
          }
          this.loadSurvey();
        } else {
          const { navigate } = this.props.navigation;
          resetTo(this, 'EligibilityNotFit');
        }
      }
    }
  }

  async showPicker() {
    this.setState({ showNext: true });

    try {
      const { action, year, month, day } = await DatePickerAndroid.open({
        date: new Date(),
      });
      if (action !== DatePickerAndroid.dismissedAction) {
        // Selected year, month (0-11), day
        this.date = new Date(year, month, day);
        this.birthDay = this.date;
        this.setState({ showDate: '' });
      }
    } catch ({ code, message }) {
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
            {i18n.t('birthday')}
          </Text>
        </View>

        <View style={{ flex: 6, flexDirection: 'row', justifyContent: 'center' }}>
          <TouchableOpacity onPress={() => this.showPicker()}>
            <View style={{ flexDirection: 'row', justifyContent: 'center' }} >

              <Text style={{ fontSize: 36, color: 'black' }}>
                {this.date.getDate()}
              </Text>
              <Text style={{ fontSize: 36, color: 'black' }}>
                {'/'}
              </Text>
              <Text style={{ fontSize: 36, color: 'black' }}>
                {this.date.getMonth() + 1}
              </Text>
              <Text style={{ fontSize: 36, color: 'black' }}>
                {'/'}
              </Text>
              <Text style={{ fontSize: 36, color: 'black' }}>
                {this.date.getFullYear()}
              </Text>
            </View>
          </TouchableOpacity>
        </View>

        <View style={{ flex: 1.5, flexDirection: 'column', justifyContent: 'center', alignItems: 'center', justifyContent: 'flex-start' }}>

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

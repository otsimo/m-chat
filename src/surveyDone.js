import React, { Component } from 'react';
import {
  View,
  Text,
  ScrollView,
  Dimensions,
  Button,
  TouchableOpacity,
  TextInput,
  ToastAndroid,
} from 'react-native';

import PopupDialog, { SlideAnimation } from 'react-native-popup-dialog';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Result } from './result.js';
import { saveEmail } from './saveEmail';
import i18n from './i18n';
import * as analytics from './analytics';

export class SurveyDone extends Component {

  static navigationOptions = {
    header: ({
      visible: false,
    }),
  };

  constructor(props) {
    super(props);
    this.email = '';
    this.state = { disableSave: false };
    analytics.screen('Survey Finished');
  }

  getText(text) {
    this.state.disableSave = false;
    this.email = text.text;
  }

  getBgColor() {
    if (this.props.navigation.state.params.resType === 'low') {
      return 'rgb(96,184,71)';
    } else if (this.props.navigation.state.params.resType === 'medium') {
      return 'rgb(225,121,38)';
    }
    return 'rgb(220,22,56)';
  }

  showSavePopUp() {
    this.popupDialogSave.show();
  }

  saveUserEmail() {
    analytics.event('Save mail clicked');
    if (this.email === '') {
      return;
    }
    if (!this.state.disableSave) {
      this.state.disableSave = true;
      saveEmail(this.email);
      ToastAndroid.show(i18n.t('emailsaved'), ToastAndroid.SHORT);
    } else {
      ToastAndroid.show(i18n.t('alreadysave'), ToastAndroid.SHORT);
    }
  }

  render() {
    return (
      <View style={{ height: Dimensions.get('window').height, backgroundColor: 'white' }}>

        <View style={{ flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>

          <View style={{ marginTop: 90, borderRadius: 60, backgroundColor: 'rgb(4,185,250)' }}>
            <Icon name="done" size={120} color="white" />
          </View>
          <Text style={{ marginTop: 10, fontSize: 50, textAlign: 'center' }}>{i18n.t('testok')}</Text>

          <TouchableOpacity
            style={{ backgroundColor: 'white', marginTop: 70 }}
            onPress={() => {
              analytics.event('Show results clicked');
              this.popupDialog.show();
            }}
          >
            <View style={{ marginTop: 50, padding: 12, borderRadius: 10, backgroundColor: 'rgb(4,185,250)' }}>

              <Text style={{ fontSize: 26, color: 'white', marginHorizontal: 25 }}>{i18n.t('showResult')}</Text>

            </View>
          </TouchableOpacity>
          <PopupDialog
            ref={(popupDialog) => { this.popupDialog = popupDialog; }}
            dialogAnimation={new SlideAnimation({ slideFrom: 'bottom' })}
            height={478}
            width={Dimensions.get('window').width - 30}
          >
            <View style={{ height: 478, backgroundColor: this.getBgColor() }}>
              <Result savePopUp={() => this.showSavePopUp()} type={this.props.navigation.state.params.resType} score={this.props.navigation.state.params.score} />
            </View>
          </PopupDialog>

          <PopupDialog
            ref={(popupDialogSave) => { this.popupDialogSave = popupDialogSave; }}
            dialogAnimation={new SlideAnimation({ slideFrom: 'bottom' })}
            height={150}
            width={Dimensions.get('window').width - 30}
          >
            <View >
              <View style={{ marginTop: 10, flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
                <Text style={{ fontSize: 18, color: 'rgb(4,165,250)' }}>
                  {i18n.t('email')}
                </Text>
                <TextInput
                  placeholder="example@example.com"
                  style={{ height: 40, marginTop: 10, width: Dimensions.get('window').width - 50 }}
                  onChangeText={(text) => this.getText({ text })}
                />
                <TouchableOpacity style={{ marginVertical: 10 }} onPress={() => this.saveUserEmail()}>
                  <View style={{ backgroundColor: 'rgb(4,165,250)', padding: 10 }}>
                    <Text style={{ color: 'white', marginHorizontal: 30 }}>
                      {i18n.t('save')}
                    </Text>
                  </View>
                </TouchableOpacity>
              </View>
            </View>
          </PopupDialog>
        </View>
      </View>
    );
  }
}

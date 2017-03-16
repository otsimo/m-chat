import React, { Component } from 'react';
import {
  View,
  Text,
  ScrollView,
  Dimensions,
  Button,
  TouchableOpacity,
} from 'react-native';

import PopupDialog, { SlideAnimation } from 'react-native-popup-dialog';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { Result } from './result.js';

export class SurveyDone extends Component {

  static navigationOptions = {
    header: ({
      visible: false,
    }),
  };

  getBgColor() {
    if (this.props.navigation.state.params.resType === 'low') {
      return 'rgb(96,184,71)';
    } else if (this.props.navigation.state.params.resType === 'medium') {
      return 'rgb(225,121,38)';
    }
    return 'rgb(220,22,56)';
  }

  render() {
    return (
      <View style={{ height: Dimensions.get('window').height, backgroundColor: 'white' }}>

        <View style={{ flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>

          <View style={{ marginTop: 90, borderRadius: 60, backgroundColor: 'rgb(4,185,250)' }}>
            <Icon name="done" size={120} color="white" />
          </View>
          <Text style={{ marginTop: 10, fontSize: 50, textAlign: 'center' }}>Testi Tamamladın</Text>

          <TouchableOpacity
            style={{ backgroundColor: 'white', marginTop: 70 }}
            onPress={() => {
              this.popupDialog.show();
            }}
          >
            <View style={{ marginTop: 50, padding: 12, borderRadius: 10, backgroundColor: 'rgb(4,185,250)' }}>

              <Text style={{ fontSize: 26, color: 'white', marginHorizontal: 25 }}>Sonucu Gör</Text>

            </View>
          </TouchableOpacity>
          <PopupDialog
            ref={(popupDialog) => { this.popupDialog = popupDialog; }}
            dialogAnimation={new SlideAnimation({ slideFrom: 'bottom' })}
            height={478}
            width={Dimensions.get('window').width - 30}
          >
            <View style={{ height: 478, backgroundColor: this.getBgColor() }}>
              <Result type={this.props.navigation.state.params.resType} score={this.props.navigation.state.params.score} />
            </View>
          </PopupDialog>
        </View>
      </View>
    );
  }
}

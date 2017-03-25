import React, { Component } from 'react';
import {
  View,
  TouchableOpacity,
  Text,
  ScrollView,
  Dimensions,
  WebView,
} from 'react-native';
import { StackNavigator } from 'react-navigation';
import i18n from './i18n';
import { MChat } from './app';
import { SurveyDone } from './surveyDone';
import { ConsentWelcome } from './consentWelcome';
import { ConsentDataGather } from './consentDataGather';
import { ConsentPrivacy } from './consentPrivacy';
import { ConsentDataUse } from './consentDataUse';
import { ConsentStudySurvey } from './consentStudySurvey';
import { ConsentPotentialBen } from './consentPotentialBen';
import { ConsentPotentialRisk } from './consentPotentialRisk';
import { ConsentMedical } from './consentMedical';
import { ConsentFollowUp } from './consentFollowUp';
import { EligibilityRelation } from './eligibilityRelation';
import { EligibilityGender } from './eligibilityGender';
import { EligibilityBday } from './eligibilityBday';
import { EligibilityNotFit } from './eligibilityNotFit';
import { Swipe } from './swipe';



export class Home extends Component {

  static navigationOptions = {
    header: ({
      visible: false,
    }),
  };
  constructor(props) {
    super(props);
    this.state = { page: 0 };
    this.lang = i18n.t('yes');
  }

  startApp() {
    // _scrollView.scrollTo({ x: Dimensions.get('window').width, animated: true }); 
    const { navigate } = this.props.navigation;
    navigate('ConsentWelcome');
  }


  handleScroll(event) {
    this.setState({ page: Math.floor(event.nativeEvent.contentOffset.x / Dimensions.get('window').width) });
    //console.warn('page', event.nativeEvent.contentOffset.x);
  }

  renderTR() {
    return (
      <View style={{ flex: 1 }}>
        <View style={{ flex: 4 }}>
          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            onScroll={(event) => this.handleScroll(event)}
            pagingEnabled
          >
            <View style={{ width: Dimensions.get('window').width, backgroundColor: 'white', flex: 1 }}>


              <WebView source={{ uri: 'file:///android_asset/webviews/homepage1TR.html' }} />


            </View>
            <View style={{ width: Dimensions.get('window').width, backgroundColor: 'red', flex: 1 }}>


              <WebView source={{ uri: 'file:///android_asset/webviews/homepage2TR.html' }} />


            </View>
            <View style={{ width: Dimensions.get('window').width, backgroundColor: 'blue', flex: 1 }}>


              <WebView source={{ uri: 'file:///android_asset/webviews/homepage3TR.html' }} />


            </View>

            <View style={{ width: Dimensions.get('window').width, backgroundColor: 'blue', flex: 1 }}>


              <WebView source={{ uri: 'file:///android_asset/webviews/homepage4TR.html' }} />


            </View>

          </ScrollView>

        </View>
        <View style={{ flex: 1, backgroundColor: '#00a9fa', flexDirection: 'column', alignItems: 'center' }}>
          <View style={{ marginTop: 5 }}>
            <Swipe page={this.state.page} />
          </View>
          <TouchableOpacity
            style={{ width: 150, height: 40, backgroundColor: 'white', borderRadius: 5, marginTop: 20, padding: 5 }}
            onPress={() => this.startApp()}
          >
            <Text style={{ padding: 5, textAlign: 'center', fontSize: 16, color: 'rgb(165,90,239)' }}> {i18n.t('join')}</Text>
          </TouchableOpacity>
        </View>
      </View>
    );

  }
  renderEN() {
    return (
      <View style={{ flex: 1 }}>
        <View style={{ flex: 4 }}>
          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            onScroll={(event) => this.handleScroll(event)}
            pagingEnabled
          >
            <View style={{ width: Dimensions.get('window').width, backgroundColor: 'white', flex: 1 }}>


              <WebView source={{ uri: 'file:///android_asset/webviews/homepage1EN.html' }} />


            </View>
            <View style={{ width: Dimensions.get('window').width, backgroundColor: 'red', flex: 1 }}>


              <WebView source={{ uri: 'file:///android_asset/webviews/homepage2EN.html' }} />


            </View>
            <View style={{ width: Dimensions.get('window').width, backgroundColor: 'blue', flex: 1 }}>


              <WebView source={{ uri: 'file:///android_asset/webviews/homepage3EN.html' }} />


            </View>

            <View style={{ width: Dimensions.get('window').width, backgroundColor: 'blue', flex: 1 }}>


              <WebView source={{ uri: 'file:///android_asset/webviews/homepage4EN.html' }} />


            </View>

          </ScrollView>

        </View>
        <View style={{ flex: 1, backgroundColor: '#00a9fa', flexDirection: 'column', alignItems: 'center' }}>
          <View style={{ marginTop: 5 }}>
            <Swipe page={this.state.page} />
          </View>
          <TouchableOpacity
            style={{ width: 150, height: 40, backgroundColor: 'white', borderRadius: 5, marginTop: 20, padding: 5 }}
            onPress={() => this.startApp()}
          >
            <Text style={{ padding: 5, textAlign: 'center', fontSize: 16, color: 'rgb(165,90,239)' }}> {i18n.t('join')}</Text>
          </TouchableOpacity>
        </View>
      </View>
    );
  }
  render() {
    if (this.lang === 'Yes') {
      return this.renderEN();
    } else {
      return this.renderTR();
    }
  }
}

export const SimpleApp = StackNavigator({
  home: { screen: Home },
  result: { screen: SurveyDone },
  app: { screen: MChat },
  ConsentWelcome: { screen: ConsentWelcome },
  ConsentDataGather: { screen: ConsentDataGather },
  ConsentPrivacy: { screen: ConsentPrivacy },
  ConsentDataUse: { screen: ConsentDataUse },
  ConsentStudySurvey: { screen: ConsentStudySurvey },
  ConsentPotentialBen: { screen: ConsentPotentialBen },
  ConsentPotentialRisk: { screen: ConsentPotentialRisk },
  ConsentMedical: { screen: ConsentMedical },
  ConsentFollowUp: { screen: ConsentFollowUp },
  EligibilityRelation: { screen: EligibilityRelation },
  EligibilityGender: { screen: EligibilityGender },
  EligibilityBday: { screen: EligibilityBday },
  EligibilityNotFit: { screen: EligibilityNotFit },
});


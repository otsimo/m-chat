import React, { Component } from 'react';
import {
  View,
  TouchableOpacity,
  Text,
  Dimensions,
  WebView,
  StyleSheet,
} from 'react-native';
import { StackNavigator } from 'react-navigation';
import Swiper from 'react-native-swiper';
import i18n from './i18n';
import * as analytics from './analytics';
import { MChat } from './app';
import { SurveyDone } from './surveyDone';
import {
  ConsentWelcome,
  ConsentDataGather,
  ConsentPrivacy,
  ConsentDataUse,
  ConsentStudySurvey,
  ConsentPotentialBen,
  ConsentPotentialRisk,
  ConsentMedical,
  ConsentFollowUp,
} from './consentPages';
import { EligibilityRelation, EligibilityGender, EligibilityBday, EligibilityNotFit } from './eligibilityPages';
import { Swipe } from './swipe';
import { Logic } from './logic';
import * as utils from './util';
import q1 from '../questionsSimple/q1.json';


export class Home extends Component {

  static navigationOptions = {
    header: ({
      visible: false,
    }),
  };
  constructor(props) {
    super(props);
    this.tempLogic = new Logic([q1]);

    this.uuid = '';
    analytics.start('production');
    this.state = { index: 1 };
    this.lang = i18n.t('yes');
  }
  async startApp() {
    try {
      const setid = await this.tempLogic.setUUID();
      const uuid = await this.tempLogic.getUUID();
      const app = {
        profileId: uuid,
      };
      analytics.setUserInfo(app);
      analytics.screen('Home');
      analytics.event('Start survey button clicked');
    } catch (err) {
      console.error('cannot get uuid');
    }
    // _scrollView.scrollTo({ x: Dimensions.get('window').width, animated: true });
    utils.navigateTo(this, 'ConsentWelcome');

  }

  get urlsForEN() {
    const urlsForEN = [
      'file:///android_asset/webviews/homepage1EN.html',
      'file:///android_asset/webviews/homepage2EN.html',
      'file:///android_asset/webviews/homepage3EN.html',
      'file:///android_asset/webviews/homepage3EN.html',
      'file:///android_asset/webviews/homepage4EN.html',
    ];
    return urlsForEN;
  }


  renderSwiper() {
    let urls = ['file:///android_asset/webviews/homepage1TR.html',
      'file:///android_asset/webviews/homepage2TR.html',
      'file:///android_asset/webviews/homepage3TR.html',
      'file:///android_asset/webviews/homepage4TR.html',
    ];
    if (this.lang === 'Yes') {
      urls = this.urlsForEN;
    }
    const pages = [];
    urls.map((url) => {
      pages.push(<View key={url} style={styles.slide1}>
        <WebView style={styles.WebView} source={{ uri: url }} />
      </View>);
    });
    return (
      <Swiper
        onMomentumScrollEnd={(e, state) => this.setState({ page: state.index })}
        animated
        loop={false}
        style={styles.wrapper}
      >
        {pages}
      </Swiper >
    );
  }

  render() {
    const h = Dimensions.get('screen').height;
    return (
      <View style={{ flex: 1, backgroundColor: 'red' }} >
        <View style={{ flex: 1, backgroundColor: 'red' }} >
          {this.renderSwiper()}
        </View>
        <View style={{ height: h / 6.8, backgroundColor: '#00a9fa', flexDirection: 'column', alignItems: 'center' }}>
          <View style={{ marginTop: 5 }}>
            <Swipe page={this.state.page} />
          </View>
          <TouchableOpacity
            style={{ width: 150, height: h / 20.5, backgroundColor: 'white', borderRadius: 5, marginTop: 20, padding: 5, justifyContent: 'center', alignItems: 'center' }}
            onPress={() => this.startApp()}
          >
            <Text style={{ padding: 5, textAlign: 'center', textAlignVertical: 'center', fontSize: 16, color: 'rgb(165,90,239)' }}> {i18n.t('join')}</Text>
          </TouchableOpacity>
        </View>
      </View >
    );
  }
}
const width = Dimensions.get('window').width;

const styles = StyleSheet.create({
  wrapper: {
  },
  slide1: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#9DD6EB',
  },
  WebView: {
    width,
    flex: 1,
  },
});

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


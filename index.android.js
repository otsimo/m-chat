import React from 'react';
import {
  AppRegistry,
  Text,
  View,
  Button,
} from 'react-native';
import { StackNavigator } from 'react-navigation';
import { MChat } from './src/app';
import { Gender } from './src/gender';
import { resetTo } from './src/util';
import { Logic } from './src/logic';
import { Home } from './src/home';
import { SurveyDone } from './src/surveyDone';
import { ConsentWelcome } from './src/consentWelcome';
import { ConsentDataGather } from './src/consentDataGather';
import { ConsentPrivacy } from './src/consentPrivacy';
import { ConsentDataUse } from './src/consentDataUse';
import { ConsentStudySurvey } from './src/consentStudySurvey';
import { ConsentPotentialBen } from './src/consentPotentialBen';
import { ConsentPotentialRisk } from './src/consentPotentialRisk';
import { ConsentMedical } from './src/consentMedical';
import { ConsentFollowUp } from './src/consentFollowUp';
 
import q1 from './questions/q1.json';
import q2 from './questions/q2.json';
import q3 from './questions/q3.json';
import q4 from './questions/q4.json';
import q5 from './questions/q5.json';
import q6 from './questions/q6.json';
import q7 from './questions/q7.json';
import q8 from './questions/q8.json';


class HomeScreen extends React.Component {
  static navigationOptions = {
    header: ({
      visible: false,
    }),
  };

  constructor(props) {
    super(props);
    this.state = {
      ok: false,
    };
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
      resetTo(this, 'ConsentWelcome', { logic: this.logic, id: '', start: true });
    } else {
      this.startSurvey();
    }
  }

  startSurvey() {
    this.logic.startSurveyTimers();
    resetTo(this, 'ConsentWelcome', { logic: this.logic });
  }
  render() {
    const { navigate } = this.props.navigation;
    return (
      <View>
        <Button
          onPress={() => this.loadSurvey()}
          title={this.state.ok ? 'Continue' : 'Start'}
        />
      </View>
    );
  }
}

const SimpleApp = StackNavigator({
  Home: { screen: HomeScreen },
  app: { screen: MChat },
  result: { screen: SurveyDone },
  ConsentWelcome: { screen: ConsentWelcome },
  ConsentDataGather: { screen: ConsentDataGather },
  ConsentPrivacy: { screen: ConsentPrivacy },
  ConsentDataUse: { screen: ConsentDataUse },
  ConsentStudySurvey: { screen: ConsentStudySurvey },
  ConsentPotentialBen: { screen: ConsentPotentialBen },
  ConsentPotentialRisk: { screen: ConsentPotentialRisk },
  ConsentMedical: { screen: ConsentMedical },
  ConsentFollowUp: { screen: ConsentFollowUp },
});

AppRegistry.registerComponent('m_chat', () => SimpleApp);

/*
import { MChat } from './src/app';

AppRegistry.registerComponent('m_chat', () => MChat);
*/

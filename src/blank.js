
  case 'MOST_OFTEN_YES': {
          for (const i in this.answers) {
            console.log('found', (this.currentStep.questions.filter(q => q.id === this.questionID)[0]).group.questions[i], act.group);
            if (this.answers[i] === 'yes' && ((this.currentStep.questions.filter(q => q.id === this.questionID)[0]).group.questions[i]) === act.group) {
              this.yesAnswers++;
              console.log('found', (this.currentStep.questions.filter(q => q.id === this.questionID)[0]).group.questions[i]);
            } else if (this.answers[i] === 'no' && ((this.currentStep.questions.filter(q => q.id === this.questionID)[0]).group.questions[i]) === act.group) {
              this.noAnswers++;
            }
          }
        }
        case 'MOST_OFTEN_NO': {

        }
        case 'ALL_OF_YES': {

        }
        case 'ALL_OF_NO': {

        }
        case 'ONE_OF_YES': {

        }
        case 'ONE_OF_NO': {

        }
        case 'TWO_OR_MORE_YES': {

        }



          <View
            style={[
              styles.bottomLine, {
                backgroundColor: this.props.isSelected ? 'rgb( 165, 90,239)' : 'transparent',
              }]}
          />





          import React from 'react';
import {
  AppRegistry,
  Text,
  View,
  Button,
} from 'react-native';
import { StackNavigator } from 'react-navigation';
import { MChat } from './src/app';
import { Gender } from './src/gender.js';
import { resetTo } from './src/util';
import { Logic } from './src/logic';
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
    title: 'Home',
  };
  componentWillMount() {
    this.logic = new Logic([q1, q2, q3]);
  }

  loadSurvey() {
    this.logic.loadState();
    resetTo(this, 'app', { logic: this.logic, id: '', start: false });
  }
  render() {
    const { navigate } = this.props.navigation;
    return (
      <View>
        <Button
          onPress={() => resetTo(this, 'app', { logic: this.logic })}
          title="Start New Survey"
        />
        <Button
          onPress={() => this.loadSurvey()}
          title="Load Survey"
        />
      </View>
    );
  }
}

const SimpleApp = StackNavigator({
  Home: { screen: HomeScreen },
  app: { screen: MChat },
  gender: { screen: Gender },
});

AppRegistry.registerComponent('m_chat', () => SimpleApp);

/*
import { MChat } from './src/app';

AppRegistry.registerComponent('m_chat', () => MChat);
*/

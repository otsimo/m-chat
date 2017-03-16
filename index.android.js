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
  componentWillMount() {
    this.logic = new Logic([q1, q2, q3]);
  }

  async loadSurvey() {
    let a = await this.logic.loadState();
    resetTo(this, 'app', { logic: this.logic, id: '', start: true });
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
        <Text>
          {this.logic.getDeviceInfo().model}
        </Text>
      </View>
    );
  }
}

const SimpleApp = StackNavigator({
  Home: { screen: HomeScreen },
  app: { screen: MChat },
  home: { screen: Home },
  result: { screen: SurveyDone },
});

AppRegistry.registerComponent('m_chat', () => SimpleApp);

/*
import { MChat } from './src/app';

AppRegistry.registerComponent('m_chat', () => MChat);
*/

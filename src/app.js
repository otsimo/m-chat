import React, { Component } from 'react';
import {
  View,
  Button,
} from 'react-native';
import { Question } from './question.js';
import { Logic } from './logic';
import q1 from '../questions/q1.json';
import q2 from '../questions/q2.json';

export class MChat extends Component {
  state = {
    viewOne: true,
  };

  changeView() {
    this.setState({
      viewOne: !this.state.viewOne,
    });
  }
  componentWillMount() {
    this.logic = new Logic([q1, q2]);
  }

  render() {
    if (!this.state.viewOne) {
      return (
        <View style={{ marginTop: 60 }}>
          <Question delegate={this.logic} />
        </View>
      );
    }
    return (
      <View>
        <View style={{ marginTop: 60 }}>
          <Button title="Start" onPress={() => this.changeView()}> change view </Button>
        </View>
      </View>
    );
  }

}

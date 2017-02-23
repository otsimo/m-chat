import React, { Component } from 'react';
import {
  View,
  Button,
  Text,
} from 'react-native';

export class Question extends Component {
  static propTypes = {
    delegate: React.PropTypes.object.isRequired,
  }
  renderYesNo() {
    return (
      <View>
        <Text>
          {this.props.delegate.currentQuestion}
        </Text>
      </View>
    );
  }

  renderGroup() {

  }

  renderEmpty() {

  }

  render() {
    const questionType = this.props.delegate.getQuestionType();
    if (questionType === 'yesno') {
      return this.renderYesNo();
    } else if (questionType === 'group') {
      return this.renderGroup();
    }
    return this.renderEmpty();
  }
}

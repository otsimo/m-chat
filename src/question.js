import React, { Component } from 'react';
import {
  View,
  Text,
  ScrollView,
  Dimensions,
} from 'react-native';
import { Buttons } from './buttons.js';
import { NextButton } from './nextButton.js';
import { CustomizedButton } from './customizedButton.js';
import { Result } from './result.js';
import { SurveyDone } from './surveyDone.js';
import { SaveToServer } from './saveToServer';

export class Question extends Component {
  static propTypes = {
    delegate: React.PropTypes.object.isRequired,
  }

  constructor(props) {
    super(props);
    this.screenWidth = Dimensions.get('window').width / 20;
    this.screenHeight = Dimensions.get('window').height;

    this.state = { question: this.props.delegate.getQuestionType(), showNext: false };
  }

  getResultType() {
    const fails = this.props.delegate.getFails();
    let resultType = '';
    if (fails < 3) {
      resultType = 'low';
    } else if (fails < 8) {
      resultType = 'medium';
    } else {
      resultType = 'high';
    }
    return resultType;
  }

  /**
   * Executes the answer which is yes or no.
   * @param {string} answer
   * @memberOf Question
   */
  executeQuestion() {
    this.props.delegate.executeAnswer(this.state.selectedOne);
    if (this.props.delegate.getQuestionType() === 'result') {
      this.props.toResult(this.getResultType(), this.props.delegate.getFails());
    } else {
      this.setState({ question: this.props.delegate.getQuestionType(), selectedOne: '', showNext: false });
    }
  }

  selectButton(name) {
    this.setState({ selectedOne: name, showNext: true });
  }

  clickedOnGroup(answer, group) {
    this.props.delegate.getGroupAnswer(answer, group);
    if (this.props.delegate.isNextShowed()) {
      this.setState({ showNext: this.props.delegate.isNextShowed() });
    }
  }
  /**
   * Executes the next step which is next question.
   * @memberOf Question
   */
  executeNextStep() {
    this.props.delegate.executeGroup();
    this.props.onUpdate();
    if (this.props.delegate.getQuestionType() === 'result') {
      SaveToServer();
      this.props.toResult(this.getResultType(), this.props.delegate.getFails());
    } else {
      this.setState({ question: this.props.delegate.getQuestionType(), showNext: false });
    }
  }
  renderYesNo() {
    if (this.state.question === 'group') {
      this.state.setState({ question: 'group' });
    }
    return (
      <View
        style={{
          height: Dimensions.get('window').height,
          marginTop: -60,
          backgroundColor: '#f7f7f7',
        }}
      >
        <View
          style={{
            flexDirection: 'row',
            justifyContent: 'flex-start',
            alignItems: 'flex-start',
            backgroundColor: 'rgb(4,165,250)',
            width: this.screenWidth * this.props.delegate.getStepId(),
            height: 5,
          }}
        />
        <View
          style={{
            marginTop: Dimensions.get('window').height / 4,
            backgroundColor: 'white',
            justifyContent: 'center',
            alignItems: 'center',
            padding: 8, //40px oran 2
          }}
        >
          <Text
            style={{
              fontSize: 18,
              marginTop: 0,
              width: 300,
              textAlign: 'center',
              //fontFamily: 'sans-serif',
            }}
          >
            {this.props.delegate.currentQuestion}
          </Text>
          <View
            style={{
              flexDirection: 'row',
              justifyContent: 'center',
              alignItems: 'center',
              backgroundColor: 'rgb(255,255,255)',
              marginTop: 12, // 60px oran 3
              marginBottom: 8,
            }}
          >
            <CustomizedButton isSelected={this.state.selectedOne === 'yes'} buttonName="Yes" onClick={() => this.selectButton('yes')} />
            <Text> | </Text>
            <CustomizedButton isSelected={this.state.selectedOne === 'no'} buttonName="No" onClick={() => this.selectButton('no')} />
          </View>
        </View>
        <NextButton enabled={this.state.showNext} onClick={() => this.executeQuestion()} />
      </View>
    );
  }

  renderGroup() {
    const keys = Object.keys((this.props.delegate.currentStep.questions.filter(
      q => q.id === this.props.delegate.questionID)[0]).group.questions);

    this.props.delegate.setNoOfQuestions(keys.length);
    return (
      <View
        style={{
          marginTop: -60,
          backgroundColor: '#f7f7f7',
        }}
      >
        <View
          style={{
            flexDirection: 'row',
            justifyContent: 'flex-start',
            alignItems: 'flex-start',
            backgroundColor: 'rgb(4,165,250)',
            marginRight: 0,
            width: this.screenWidth * this.props.delegate.getStepId(),
            height: 5,
          }}
        >
          <Text />
        </View>
        <ScrollView
          style={{
            height: Dimensions.get('window').height - 65,
            backgroundColor: '#f7f7f7',
          }}
        >
          <View
            style={{
              marginBottom: 5,
              justifyContent: 'space-between',
              alignItems: 'center',
              backgroundColor: 'rgb(255,255,255)',
              padding: 8,
            }}
          >
            <Text
              style={{
                fontSize: 18,
                marginTop: 0,
                width: 300,
                textAlign: 'center',
              }}
            >
              {this.props.delegate.currentQuestion}
            </Text>
          </View>
          {keys.map(v => (
            <View
              key={v} style={{
                padding: 8,
                margin: 8,
                justifyContent: 'space-between',
                alignItems: 'center',
                backgroundColor: 'rgb(255,255,255)',
              }}
            >
              <Text
                style={{
                  fontSize: 18,
                  width: 300,
                  textAlign: 'center',
                }}
              > {(this.props.delegate.currentStep.questions.filter(
                q => q.id === v)[0]).text}
              </Text>

              <View
                style={{
                  flexDirection: 'column',
                  margin: 4,
                  justifyContent: 'center',
                  alignItems: 'center',
                }}
              >
                <Buttons
                  onclick={answer => this.clickedOnGroup(answer,
                    (this.props.delegate.currentStep.questions.filter(
                      q => q.id === v)[0]).id)} selectionChanged={(newSelection) => { console.log('selection changed to ', newSelection); }}
                />
              </View>
            </View>
          ),
          )
          }
          <View style={{ marginTop: -8 }}>
            <NextButton enabled={this.state.showNext} onClick={() => this.executeNextStep()} />
          </View>
        </ScrollView>
      </View>
    );
  }

  renderResultScreen() {
    let dim = Dimensions.get('window');
    let w = dim.width;
    let h = dim.height;

    //const passes = this.props.delegate.getPasses();
    const fails = this.props.delegate.getFails();
    let resultType = '';
    if (fails < 3) {
      resultType = 'low';
    } else if (fails < 8) {
      resultType = 'medium';
    } else {
      resultType = 'high';
    }

    return (
      <View style={{ marginTop: -60, width: w, height: h, backgroundColor: 'rgb(255,255,255)' }}>
        <SurveyDone type={resultType} score={fails} />
      </View>
    );
  }
  renderEmpty() {
    return (
      <View>
        <Text>
          Blank
          </Text>
      </View>
    );
  }

  render() {
    this.state.question = this.props.delegate.getQuestionType();
    console.log('questiontype', this.state.question);
    console.log('id', this.props.delegate.getStepId());
    if (this.state.question === 'yesno') {
      return this.renderYesNo();
    } else if (this.state.question === 'group') {
      return this.renderGroup();
    } else if (this.state.question === 'result') {
      return this.renderResultScreen();
    }
    return this.renderEmpty();
  }
}

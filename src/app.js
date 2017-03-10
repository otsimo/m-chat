import React, { Component } from 'react';
import {
  View,
  Button,
  TouchableOpacity,
  Modal,
  Text,
  TouchableWithoutFeedback,
  BackAndroid,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';

import { Question } from './question.js';
import { Logic } from './logic';
import { modalDispatcher } from './events';

import q1 from '../questions/q1.json';
import q2 from '../questions/q2.json';
import q3 from '../questions/q3.json';
import q4 from '../questions/q4.json';

export class MChat extends Component {

  static navigationOptions = {
    title: (navigation, childRouter) => 'Step ' + navigation.state.params.logic.getStepId() + ' of 20',

    header: ({ state, setParams }) => ({
      // Render a button on the right side of the header
      // When pressed switches the screen to edit mode.
      right: (
        <TouchableOpacity>
          <Icon name="more-vert" size={30} onPress={() => modalDispatcher.emit('OPEN_MODAL', {})} />
        </TouchableOpacity>
      ),
    }),
  };

  state = {
    viewOne: true,
    modalVisible: false,
  };

  static triggerModal() {
    this.setState({
      modalVisible: !this.state.modalVisible,
    });
  }
  changeView() {
    this.changeTitle();
    this.setState({
      viewOne: !this.state.viewOne,
    });
  }

  componentWillMount() {
    this.logic = new Logic([q1, q2]);
    this.subs = modalDispatcher.addListener('OPEN_MODAL', this.onModalClick.bind(this));
    BackAndroid.addEventListener('hardwareBackPress', this.onModalClick.bind(this));
  }

  onModalClick() {
    console.log('modalopen');
    if (this.refs.modal) {
      this.setState({
        modalVisible: !this.state.modalVisible,
      });
    }
    return true;
  }

  componentWillUnmount() {
    modalDispatcher.removeListener('OPEN_MODAL', this.onModalClick);
    BackAndroid.removeEventListener('hardwareBackPress', this.onModalClick);
  }

  changeTitle(nTitle) {
    this.navigationOptions.title = nTitle;
  }
  _setModalVisible(cmd) {
    this.setState({
      modalVisible: cmd,
    });
    console.log('modalclose');
  }

  changeTitle() {
    this.props.navigation.setParams({logic: this.props.navigation.state.params.logic });
  }

  saveAndQuit() {
    this.props.navigation.state.params.logic.saveState();
    BackAndroid.exitApp();
  }

  render() {
    if (!this.state.viewOne) {
      return (
        <View>
          <Modal ref="modal"
            transparent
            visible={this.state.modalVisible}
            onRequestClose={() => this._setModalVisible(false)}
            animationType={'fade'}
          >
            <TouchableWithoutFeedback onPress={() => this._setModalVisible(false)}>
              <View
                style={{
                  flex: 1,
                  flexDirection: 'row',
                  justifyContent: 'flex-end',
                  alignItems: 'flex-start',
                  marginTop: 2,
                }}
              >
                <View
                  style={{
                    width: 100,
                    height: 200,
                    backgroundColor: 'rgb(247,247,247)',
                  }}
                >
                  <Button title="Save&Quit" onPress={() => this.saveAndQuit()} />
                  <Button title="Quit" onPress={() => BackAndroid.exitApp()} />
                </View>
              </View>
            </TouchableWithoutFeedback>
          </Modal>
          <View style={{ marginTop: 60 }}>
            <Question onUpdate={() => this.changeTitle()} delegate={this.props.navigation.state.params.logic} />
          </View>
        </View>
      );
    }
    return (
      <View>
        <Modal
          ref="modal"
          transparent
          visible={this.state.modalVisible}
          onRequestClose={() => this._setModalVisible(false)}
          onRequestHide={this.onModalClick}
          animationType={'fade'}
        >
          <TouchableWithoutFeedback onPress={() => this._setModalVisible(false)}>
            <View
              style={{
                flex: 2,
                flexDirection: 'row',
                justifyContent: 'flex-end',
                alignItems: 'flex-start',
                marginTop: 2,
              }}
            >
              <View
                style={{
                  width: 100,
                  height: 200,
                  backgroundColor: 'rgb(247,247,247)',
                }}
              >
                <Button title="Save&Quit" onPress={() => this.saveAndQuit()} />
                <Button title="Quit" onPress={() => BackAndroid.exitApp()} />
              </View>
            </View>
          </TouchableWithoutFeedback>
        </Modal>
        <View style={{ marginTop: 60 }}>
          <Button title="Start" onPress={() => this.changeView()}> change view </Button>
        </View>
      </View>
    );
  }
}

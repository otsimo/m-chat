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
import { ModalButton } from './modalButtons';

import q1 from '../questions/q1.json';
import q2 from '../questions/q2.json';
import q3 from '../questions/q3.json';
import q4 from '../questions/q4.json';

export class MChat extends Component {

  static navigationOptions = {
    title: (navigation, childRouter) => navigation.state.params.start ? 'Step ' + navigation.state.params.id + ' of 20' : '',

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

  _setModalVisible(cmd) {
    this.setState({
      modalVisible: cmd,
    });
    console.log('modalclose');
  }

  changeTitle() {
    this.props.navigation.setParams({ start: true, id: this.props.navigation.state.params.logic.getStepId() });
  }

  saveAndQuit() {
    this.props.navigation.state.params.logic.saveState();
    BackAndroid.exitApp();
  }

  render() {
    if (!this.state.viewOne) {
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
                flex: 1,
                flexDirection: 'row',
                justifyContent: 'flex-end',
                alignItems: 'flex-start',
                marginTop: 2,
              }}
            >
            <View
                style={{
                  borderRadius: 10,
                  marginRight: -150,
                  width: 154,
                  height: 104,
                  backgroundColor: '#000000',
                  opacity: 0.05,
                }}
              />
              <View
                style={{
                  width: 150,
                  height: 100,
                  backgroundColor: 'white',
                }}
              >
                <ModalButton name="Save&Quit" onPress={() => this.saveAndQuit()} />
                <ModalButton name="Quit" onPress={() => BackAndroid.exitApp()} />

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
                flex: 1,
                flexDirection: 'row',
                justifyContent: 'flex-end',
                alignItems: 'flex-start',
                marginTop: 2,
              }}
            >
            <View
                style={{
                  borderRadius: 10,
                  marginRight: -150,
                  width: 154,
                  height: 104,
                  backgroundColor: '#000000',
                  opacity: 0.05,
                }}
              />
              <View
                style={{
                  width: 150,
                  height: 100,
                  backgroundColor: 'white',
                }}
              >
                <ModalButton name="Save&Quit" onPress={() => this.saveAndQuit()} />
                <ModalButton name="Quit" onPress={() => BackAndroid.exitApp()} />

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

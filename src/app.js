import React, { Component } from 'react';
import {
  View,
  TouchableOpacity,
  Modal,
  TouchableWithoutFeedback,
  BackAndroid,
  NativeModules,
  Platform,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';

import { Question } from './question.js';
import { Logic } from './logic';
import { modalDispatcher } from './events';
import { ModalButton } from './modalButtons';
import { resetTo } from './util';
import i18n from './i18n';

import q1 from '../questions/q1.json';
import q2 from '../questions/q2.json';
import q3 from '../questions/q3.json';
import q4 from '../questions/q4.json';

if (Platform.OS !== 'ios') {
  i18n.locale = NativeModules.OtsimoDeviceInfo.deviceLocale;
}

//i18n.t('stepOf', { current: 0, total: 20 });

export class MChat extends Component {

  static navigationOptions = {
    title: (navigation, childRouter) => navigation.state.params.start ? (i18n.t('stepOf', { current: navigation.state.params.id, total: 23 })) : '',

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

  navigateToResult(resultType, _score) {
    this.logic = new Logic([q1, q2, q3]);
    this.logic.removeState();
    resetTo(this, 'result', { resType: resultType, score: _score });
  }
  changeView() {
    this.changeTitle();
    this.setState({
      viewOne: !this.state.viewOne,
    });
  }

  componentWillMount() {
    this.subs = modalDispatcher.addListener('OPEN_MODAL', this.onModalClick.bind(this));
    BackAndroid.addEventListener('hardwareBackPress', this.onModalClick.bind(this));
    this.changeTitle();
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

  saveState() {
    this._setModalVisible(false);
    this.props.navigation.state.params.logic.saveState();
  }

  resetSurvey() {
    this._setModalVisible(false);
    this.logic = new Logic([q1, q2, q3]);
    this.logic.removeState();
    resetTo(this, 'app', { logic: this.logic, start: true, id: this.logic.getStepId() });
  }

  render() {
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
                <ModalButton name={i18n.t('save')} onPress={() => this.saveState()} />
                <ModalButton name={i18n.t('reset')} onPress={() => this.resetSurvey()} />

              </View>
            </View>
          </TouchableWithoutFeedback>
        </Modal>
        <View style={{ marginTop: 60 }}>
         
          <Question onUpdate={() => this.changeTitle()} toResult={(resultType, _score) => this.navigateToResult(resultType, _score)} delegate={this.props.navigation.state.params.logic} />
        </View>
      </View>
    );
  }
}

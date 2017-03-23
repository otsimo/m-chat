import React, { Component } from 'react';
import { View, Text, TouchableOpacity, Image, Dimensions, Modal, TouchableWithoutFeedback, WebView, TouchableNativeFeedback } from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { NextButton } from './nextButton';
import i18n from './i18n';


export class ConsentPrefab extends Component {

  constructor(props) {
    super(props);
    this.textHeader = this.props.textHeader;
    this.text = this.props.text;
  }
  state = {
    modalVisible: false,
  }

  _setModalVisible(cmd) {
    this.setState({
      modalVisible: cmd,
    });
  }

  openModal() {
    this.setState({
      modalVisible: true,
    });
  }

  render() {
    return (

      <View style={{ flex: 1, flexDirection: 'column', backgroundColor: 'white' }}>
        <Modal
          ref="modal"
          visible={this.state.modalVisible}
          onRequestClose={() => this._setModalVisible(false)}
          animationType={'fade'}
        >
          <View
            style={{
              flex: 1,
              flexDirection: 'column',
            }}
          >
            <View style={{ height: 45, marginLeft: 15,marginTop: 10 }}>
              <TouchableNativeFeedback onPress={() => this._setModalVisible(false)}>
                <Icon name="close" size={25} color="black" />
              </TouchableNativeFeedback>
            </View>
            <WebView source={{ uri: this.props.learnURL }} style={{ marginTop: 0 }} />

          </View>

        </Modal>

        <View style={{ flex: 3, flexDirection: 'column', justifyContent: 'center', alignItems: 'center' }}>
          <Image resizeMode="contain" style={{ marginTop: 5, height: Dimensions.get('window').height * 2 / 10, width: Dimensions.get('window').width }} source={this.props.image} />
        </View>

        <View style={{ flex: 6, flexDirection: 'column', backgroundColor: 'white', alignItems: 'center' }}>

          <View style={{ margin: 30 }}>
            <Text style={{ fontSize: 30, textAlign: 'center', color: 'black' }}>
              {this.props.textHeader}
            </Text>
          </View>

          <View>
            <Text style={{ fontSize: 18, textAlign: 'center', color: 'black', marginHorizontal: 10 }}>
              {this.props.text}
            </Text>
          </View>

          <View style={{ marginVertical: 10 }}>
            <TouchableOpacity onPress={() => this.openModal()}>
              <Text style={{ fontSize: 14, textAlign: 'center', color: '#9c48ed', marginHorizontal: 10 }}>
                {i18n.t('learn')}
              </Text>
            </TouchableOpacity>
          </View>

        </View>


        <View style={{ flex: 1, flexDirection: 'column' }}>
          <TouchableOpacity onPress={() => this.props.onPress()} style={{ flex: 1, backgroundColor: '#00a9fa', justifyContent: 'center' }}>
            <View>
              <Text style={{ color: 'white', fontSize: 26, textAlign: 'center' }}>
                {i18n.t('next')}
              </Text>
            </View>
          </TouchableOpacity>
        </View>
      </View>
    );
  }
}

import React, { Component } from 'react';
import { View, Text, TouchableOpacity, Image } from 'react-native';
import { NextButton } from './nextButton';
import i18n from './i18n';


export class ConsentPrefab extends Component {

  constructor(props) {
    super(props);
    this.imageURL = this.props.imageURL;
    this.textHeader = this.props.textHeader;
    this.text = this.props.text;
  }

  render() {
    return (
      <View style={{ flex: 1, flexDirection: 'column' }}>
        <View style={{ flex: 3, flexDirection: 'column', backgroundColor: 'pink', justifyContent: 'center', alignItems: 'center' }}>
          <Image source={require('../gifs/download.png')} />
        </View>

        <View style={{ flex: 6, flexDirection: 'column', backgroundColor: 'white', alignItems: 'center' }}>

          <View style={{ margin: 30 }}>
            <Text style={{ fontSize: 30, textAlign: 'center' }}>
              {this.props.textHeader}
            </Text>
          </View>

          <View>
            <Text style={{ fontSize: 18, textAlign: 'center' }}>
              {this.props.text}
            </Text>
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

import React, { Component } from 'react';
import {
  View,
  TouchableOpacity,
  Text,
  ScrollView,
  Dimensions,
  WebView,
} from 'react-native';

export class Swipe extends Component {




  render() {
    return (
      <View style={{ flexDirection: 'row' }} >
        <View style={{ backgroundColor: this.props.page === 0 ? 'rgb(165,90,239)' : 'white', width: 10, height: 10, margin: 3, borderRadius: 60 }}>
        </View>

        <View style={{ backgroundColor: this.props.page === 1 ? 'rgb(165,90,239)' : 'white', width: 10, height: 10, margin: 3, borderRadius: 60 }}>
        </View>

        <View style={{ backgroundColor: this.props.page === 2 ? 'rgb(165,90,239)' : 'white', width: 10, height: 10, margin: 3, borderRadius: 60 }}>
        </View>

        <View style={{ backgroundColor: this.props.page === 3 ? 'rgb(165,90,239)' : 'white', width: 10, height: 10, margin: 3, borderRadius: 60 }}>
        </View>

        <View style={{ backgroundColor: this.props.page === 4 ? 'rgb(165,90,239)' : 'white', width: 10, height: 10, margin: 3, borderRadius: 60 }}>
        </View>


      </View>
    );
  }
}
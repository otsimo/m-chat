import React, { Component } from 'react';
import {
  View,
  Button,
  TouchableOpacity,
  Modal,
  Text,
  TouchableWithoutFeedback,
  BackAndroid,
  ScrollView,
  Dimensions,
  WebView,
} from 'react-native';

export class Home extends Component {
  render() {
    let _scrollView: ScrollView;
    return (
      <View style={{ flex: 1 }}>
        <View style={{ flex: 4 }}>
          <ScrollView
            horizontal
            pagingEnabled
            ref={(scrollView) => { _scrollView = scrollView; }}
          >
            <View style={{ width: Dimensions.get('window').width, backgroundColor: 'white', flex: 1 }}>


              <WebView />


            </View>
            <View style={{ width: Dimensions.get('window').width, backgroundColor: 'red', flex: 1 }}>


              <WebView />


            </View>
            <View style={{ width: Dimensions.get('window').width, backgroundColor: 'blue', flex: 1 }}>


              <WebView />


            </View>

          </ScrollView>

        </View>
        <View style={{ flex: 1, backgroundColor: 'rgb(91,57,177)', flexDirection: 'column', alignItems: 'center' }}>
          <TouchableOpacity
            style={{ width: 150, height: 40, backgroundColor: 'white', borderRadius: 5, marginTop: 30, padding: 5 }}
            onPress={() => { _scrollView.scrollTo({ x: Dimensions.get('window').width, animated: true }); }}
          >
            <Text style={{ padding: 5, textAlign: 'center', fontSize: 16, color: 'rgb(165,90,239)' }}> Join Study</Text>
          </TouchableOpacity>
        </View>
      </View>
    );
  }
}

import React, { Component } from 'react';
import {
  View,
  Text,
  ScrollView,
  Dimensions,
} from 'react-native';

export class Result extends Component {
  render() {
    return (
      <View style={{ height: Dimensions.get('window').height, backgroundColor: 'white' }}>
        <View style={{ height: Dimensions.get('window').height / 5, flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: 20 }} >
          <Text style={{ color: 'rgb(211,0,76)', fontSize: 40, fontWeight: 'bold' }}>Yüksek Düzey</Text>
          <Text style={{ color: 'rgb(211,0,76)', fontSize: 40, fontWeight: 'bold' }}>Otizm Şüphesi</Text>
        </View>
        <View
          style={{
            height: 4 * Dimensions.get('window').height / 5,
            flexDirection: 'column',
            alignItems: 'center',
            backgroundColor: 'rgb(220,22,56)',
            padding: 10,
          }}
        >
          <Text style={{ color: 'rgb(255,255,255)', fontSize: 25, fontWeight: 'bold', textAlign: 'center' }}>Çocuk mutlaka bir çocuk psikiyatristine yönlendirilmelidir</Text>
          <View style={{ marginTop: 15, alignItems: 'center' }}>
            <Text style={{ color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>M-Chat Testinden</Text>
            <Text style={{ color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>Alınan Puan:</Text>
          </View>

          <View style={{ marginTop: 5, alignItems: 'center' }}>
            <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>
              Not
              </Text>
          </View>
          <View style={{ backgroundColor: 'white', height: 1, width: 200 }}>

          </View>
          <View style={{ marginTop: 5, alignItems: 'center' }}>
            <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 15, fontWeight: 'bold' }}>
              M-CHAT tanı koymaya yönelik bir araç değildir. Bir çocuğun M-CHAT'te başarısız olması o çocuğun otizm spektrum bozukluğu tanısı aldığı anlamına gelmemektedir. Bu sonuç sadece 'şüphe' bildirmektedir.
                </Text>
          </View>
        </View>
      </View>
    );
  }
}

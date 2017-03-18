import React, { Component } from 'react';
import {
  View,
  Text,
  ScrollView,
  Dimensions,
  Button,
  TouchableOpacity,
  Share,
} from 'react-native';

export class Result extends Component {

  constructor(props) {
    super(props);


    this.state = {
      result: '',
    };
  }
  _shareMessage() {
    Share.share({
      message: 'React Native | A framework for building native apps using React',
    });
  }

  renderHigh() {
    return (
      <View style={{ backgroundColor: 'white' }}>
        <View style={{ flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: 20 }} >
          <Text style={{ color: 'rgb(211,0,76)', fontSize: 40, fontWeight: 'bold' }}>Yüksek Düzey</Text>
          <Text style={{ color: 'rgb(211,0,76)', fontSize: 40, fontWeight: 'bold' }}>Otizm Şüphesi</Text>
        </View>
        <View
          style={{
            flexDirection: 'column',
            alignItems: 'center',
            backgroundColor: 'rgb(220,22,56)',
            padding: 10,
          }}
        >
          <Text style={{ color: 'rgb(255,255,255)', fontSize: 25, fontWeight: 'bold', textAlign: 'center' }}>Çocuk mutlaka bir çocuk psikiyatristine yönlendirilmelidir</Text>
          <View style={{ marginTop: 8, alignItems: 'center' }}>
            <Text style={{ color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>M-Chat Testinden</Text>
            <Text style={{ color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>Alınan Puan: {this.props.score}</Text>
          </View>


          <View style={{ backgroundColor: 'white', height: 1, width: 200 }}>
          </View>
          <View style={{ marginTop: 5, alignItems: 'center' }}>
            <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 15, fontWeight: 'bold' }}>
              M-CHAT tanı koymaya yönelik bir araç değildir. Bir çocuğun M-CHAT'te başarısız olması o çocuğun otizm spektrum bozukluğu tanısı aldığı anlamına gelmemektedir. Bu sonuç sadece 'şüphe' bildirmektedir.
                </Text>
          </View>

          <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between' }}>

            <View style={{ marginTop: 10, marginRight: 5, alignItems: 'center', backgroundColor: 'white', padding: 2 }} >
              <View style={{ backgroundColor: 'rgb(220,22,56)' }}>
                <TouchableOpacity >
                  <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold', marginHorizontal: 30, marginVertical: 10 }}>
                    Kaydet
              </Text >
                </TouchableOpacity>

              </View>
            </View>

            <View style={{ marginTop: 10, alignItems: 'center', backgroundColor: 'white', padding: 2 }} >
              <View style={{ backgroundColor: 'rgb(220,22,56)' }}>
                <TouchableOpacity onPress={this._shareMessage} >
                  <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold', marginHorizontal: 30, marginVertical: 10 }}>
                    Paylaş
              </Text >
                </TouchableOpacity>
              </View>
            </View>
          </View>
        </View>
      </View>
    );
  }
  renderLow() {
    return (
      <View style={{ height: 478 }}>
        <View style={{ flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: 20, backgroundColor: 'white' }} >
          <Text style={{ color: 'rgb(87,157,67)', fontSize: 40, fontWeight: 'bold' }}>Otizm Şüphesi</Text>
          <Text style={{ color: 'rgb(87,157,67)', fontSize: 40, fontWeight: 'bold' }}>Yoktur</Text>
        </View>
        <View
          style={{
            flexDirection: 'column',
            alignItems: 'center',
            backgroundColor: 'rgb(96,184,71)',
            padding: 10,

          }}
        >
          <Text style={{ color: 'rgb(255,255,255)', fontSize: 25, fontWeight: 'bold', textAlign: 'center' }}>İlave bir test yapılmasına ihtiyaç yoktur</Text>
          <View style={{ marginTop: 15, alignItems: 'center' }}>
            <Text style={{ color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>M-Chat Testinden</Text>
            <Text style={{ color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>Alınan Puan: {this.props.score}</Text>
          </View>

          <View style={{ backgroundColor: 'white', height: 1, width: 200 }}>
          </View>
          <View style={{ marginTop: 20, alignItems: 'center' }}>
            <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 15, fontWeight: 'bold' }}>
              Ancak M-CHAT çocuğa 24 aylıktan önce uygulanmış ise çocuğun gelişiminin takip edilip 24 aylıkken bu testin tekrardan uygulanması ve sonuçların tekrardan değerlendirilmesi gereklidir.
                </Text>
          </View>

          <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between' }}>

            <View style={{ margin: 10, marginRight: 5, alignItems: 'center', backgroundColor: 'white', padding: 2 }} >
              <View style={{ backgroundColor: 'rgb(96,184,71)' }}>
                <TouchableOpacity onPress={() => this.props.savePopUp()}>
                  <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold', marginHorizontal: 30, marginVertical: 10 }}>
                    Kaydet
              </Text >
                </TouchableOpacity>

              </View>
            </View>

            <View style={{ margin: 10, alignItems: 'center', backgroundColor: 'white', padding: 2 }} >
              <View style={{ backgroundColor: 'rgb(96,184,71)' }}>
                <TouchableOpacity onPress={this._shareMessage}>
                  <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold', marginHorizontal: 30, marginVertical: 10 }}>
                    Paylaş
              </Text >
                </TouchableOpacity>

              </View>
            </View>


          </View>
        </View>
      </View>
    );
  }

  renderMedium() {
    return (
      <View style={{ backgroundColor: 'white' }}>
        <View style={{ flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: 20 }} >
          <Text style={{ color: 'rgb(203,94,47)', fontSize: 40, fontWeight: 'bold' }}>Orta Düzey</Text>
          <Text style={{ color: 'rgb(203,94,47)', fontSize: 40, fontWeight: 'bold' }}>Otizm Şüphesi</Text>
        </View>
        <View
          style={{
            flexDirection: 'column',
            alignItems: 'center',
            backgroundColor: 'rgb(225,121,38)',
            padding: 10,
          }}
        >
          <Text style={{ color: 'rgb(255,255,255)', fontSize: 25, fontWeight: 'bold', textAlign: 'center' }}>Çocuk bir çocuk psikiyatristine yönlendirilmelidir</Text>
          <View style={{ marginTop: 8, alignItems: 'center' }}>
            <Text style={{ color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>M-Chat Testinden</Text>
            <Text style={{ color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>Alınan Puan: {this.props.score}</Text>
          </View>

          <View style={{ backgroundColor: 'white', height: 1, width: 200 }}>

          </View>
          <View style={{ marginTop: 5, alignItems: 'center' }}>
            <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 15, fontWeight: 'bold' }}>
              M-CHAT tanı koymaya yönelik bir araç değildir. Bir çocuğun M-CHAT'te başarısız olması o çocuğun otizm spektrum bozukluğu tanısı aldığı anlamına gelmemektedir. Bu sonuç sadece 'şüphe' bildirmektedir.
                </Text>
          </View>
          <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between' }}>

            <View style={{ marginTop: 10, marginRight: 5, alignItems: 'center', backgroundColor: 'white', padding: 2 }} >
              <View style={{ backgroundColor: 'rgb(225,121,38)' }}>
                <TouchableOpacity >
                  <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold', marginHorizontal: 30, marginVertical: 10 }}>
                    Kaydet
              </Text >
                </TouchableOpacity>

              </View>
            </View>

            <View style={{ marginTop: 10, alignItems: 'center', backgroundColor: 'white', padding: 2 }} >
              <View style={{ backgroundColor: 'rgb(225,121,38)' }}>
                <TouchableOpacity onPress={this._shareMessage} >
                  <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold', marginHorizontal: 30, marginVertical: 10 }}>
                    Paylaş
              </Text >
                </TouchableOpacity>

              </View>
            </View>


          </View>
        </View>
      </View>
    );
  }
  render() {
    if (this.props.type === 'low') {
      return this.renderLow();
    } else if (this.props.type === 'medium') {
      return this.renderMedium();
    } else if (this.props.type === 'high') {
      return this.renderHigh();
    }
    return (
      <View>
      </View>
    );
  }
}

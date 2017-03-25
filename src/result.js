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
import i18n from './i18n';

export class Result extends Component {

  constructor(props) {
    super(props);


    this.state = {
      result: '',
    };
  }
  _shareMessage(lvl) {
    Share.share({
      message: (i18n.t('sharetext', { level: lvl, score: this.props.score }) + i18n.t('sharelink')),
    });
  }

  renderHigh() {
    return (
      <View style={{ backgroundColor: 'white' }}>
        <View style={{ flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: 20 }} >
          <Text style={{ color: 'rgb(211,0,76)', fontSize: 40, fontWeight: 'bold' }}>{i18n.t('highlevel')}</Text>
          <Text style={{ color: 'rgb(211,0,76)', fontSize: 40, fontWeight: 'bold' }}>{i18n.t('autismdoubt')}</Text>
        </View>
        <View
          style={{
            flexDirection: 'column',
            alignItems: 'center',
            backgroundColor: 'rgb(220,22,56)',
            padding: 10,
          }}
        >
          <Text style={{ color: 'rgb(255,255,255)', fontSize: 25, fontWeight: 'bold', textAlign: 'center' }}> {i18n.t('highrisktext1')} </Text>
          <View style={{ marginTop: 8, alignItems: 'center' }}>
            <Text style={{ color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>M-Chat Test</Text>
            <Text style={{ color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>{i18n.t('score') + this.props.score}</Text>
          </View>


          <View style={{ backgroundColor: 'white', height: 1, width: 200 }}>
          </View>
          <View style={{ marginTop: 5, alignItems: 'center' }}>
            <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 15, fontWeight: 'bold' }}>
              {i18n.t('highrisktext2')}
            </Text>
          </View>

          <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between' }}>

            <View style={{ marginTop: 10, marginRight: 5, alignItems: 'center', backgroundColor: 'white', padding: 2 }} >
              <View style={{ backgroundColor: 'rgb(220,22,56)' }}>
                <TouchableOpacity onPress={() => this.props.savePopUp()} >
                  <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold', marginHorizontal: 30, marginVertical: 10 }}>
                    {i18n.t('save')}
                  </Text >
                </TouchableOpacity>

              </View>
            </View>

            <View style={{ marginTop: 10, alignItems: 'center', backgroundColor: 'white', padding: 2 }} >
              <View style={{ backgroundColor: 'rgb(220,22,56)' }}>
                <TouchableOpacity onPress={() => this._shareMessage('High')} >
                  <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold', marginHorizontal: 30, marginVertical: 10 }}>
                    {i18n.t('share')}
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
          <Text style={{ color: 'rgb(87,157,67)', fontSize: 40, fontWeight: 'bold' }}> {i18n.t('autismdoubt')}</Text>
          <Text style={{ color: 'rgb(87,157,67)', fontSize: 40, fontWeight: 'bold' }}>{i18n.t('none')}</Text>
        </View>
        <View
          style={{
            flexDirection: 'column',
            alignItems: 'center',
            backgroundColor: 'rgb(96,184,71)',
            padding: 10,

          }}
        >
          <Text style={{ color: 'rgb(255,255,255)', fontSize: 25, fontWeight: 'bold', textAlign: 'center' }}>{i18n.t('lowleveltext1')}</Text>
          <View style={{ marginTop: 15, alignItems: 'center' }}>
            <Text style={{ color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>M-Chat Test</Text>
            <Text style={{ color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>{i18n.t('score') + this.props.score}</Text>
          </View>

          <View style={{ backgroundColor: 'white', height: 1, width: 200 }}>
          </View>
          <View style={{ marginTop: 20, alignItems: 'center' }}>
            <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 15, fontWeight: 'bold' }}>
              {i18n.t('lowleveltext2')}
            </Text>
          </View>

          <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between' }}>

            <View style={{ margin: 10, marginRight: 5, alignItems: 'center', backgroundColor: 'white', padding: 2 }} >
              <View style={{ backgroundColor: 'rgb(96,184,71)', paddingHorizontal: 30 }}>
                <TouchableOpacity onPress={() => this.props.savePopUp()}>
                  <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold', marginVertical: 10 }}>
                    {i18n.t('save')}
                  </Text >
                </TouchableOpacity>

              </View>
            </View>

            <View style={{ margin: 10, alignItems: 'center', backgroundColor: 'white', padding: 2 }} >
              <View style={{ backgroundColor: 'rgb(96,184,71)' }}>
                <TouchableOpacity onPress={() => this._shareMessage('Low')}>
                  <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold', marginHorizontal: 30, marginVertical: 10 }}>
                    {i18n.t('share')}
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
          <Text style={{ color: 'rgb(203,94,47)', fontSize: 40, fontWeight: 'bold' }}>{i18n.t('mediumlevel')}</Text>
          <Text style={{ color: 'rgb(203,94,47)', fontSize: 40, fontWeight: 'bold' }}>{i18n.t('autismdoubt')}</Text>
        </View>
        <View
          style={{
            flexDirection: 'column',
            alignItems: 'center',
            backgroundColor: 'rgb(225,121,38)',
            padding: 10,
          }}
        >
          <Text style={{ color: 'rgb(255,255,255)', fontSize: 25, fontWeight: 'bold', textAlign: 'center' }}>{i18n.t('mediumleveltext1')}</Text>
          <View style={{ marginTop: 8, alignItems: 'center' }}>
            <Text style={{ color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>M-Chat Test</Text>
            <Text style={{ color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold' }}>{i18n.t('score') + this.props.score}</Text>
          </View>

          <View style={{ backgroundColor: 'white', height: 1, width: 200 }}>

          </View>
          <View style={{ marginTop: 5, alignItems: 'center' }}>
            <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 15, fontWeight: 'bold' }}>
              {i18n.t('mediumleveltext2')}
            </Text>
          </View>
          <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between' }}>

            <View style={{ marginTop: 10, marginRight: 5, alignItems: 'center', backgroundColor: 'white', padding: 2 }} >
              <View style={{ backgroundColor: 'rgb(225,121,38)' }}>
                <TouchableOpacity onPress={() => this.props.savePopUp()} >
                  <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold', marginHorizontal: 30, marginVertical: 10 }}>
                    {i18n.t('save')}
                  </Text >
                </TouchableOpacity>

              </View>
            </View>

            <View style={{ marginTop: 10, alignItems: 'center', backgroundColor: 'white', padding: 2 }} >
              <View style={{ backgroundColor: 'rgb(225,121,38)' }}>
                <TouchableOpacity onPress={() => this._shareMessage('Medium')} >
                  <Text style={{ textAlign: 'center', color: 'rgb(255,255,255)', fontSize: 20, fontWeight: 'bold', marginHorizontal: 30, marginVertical: 10 }}>
                    {i18n.t('share')}
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

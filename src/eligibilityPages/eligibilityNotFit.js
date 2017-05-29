import React, { Component } from 'react';
import { View, Text, TouchableOpacity } from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import i18n from '../i18n';
import { resetTo } from '../util';


export class EligibilityNotFit extends Component {
  static navigationOptions = {
    header: ({
      visible: false,
    }),
  };

  render() {
    return (
      <View style={{ flex: 1, flexDirection: 'column', justifyContent: 'center', backgroundColor: 'white' }}>
        <View style={{ flex: 4, flexDirection: 'column', justifyContent: 'center', alignItems: 'center' }}>

          <Icon name="cancel" size={130} color="black" />
        </View>

        <View style={{ flex: 6, flexDirection: 'column' }}>
          <Text style={{ color: 'black', fontSize: 36, textAlign: 'center', alignItems: 'center' }}>
            {i18n.t('noteligible')}
          </Text>


          <View style={{ marginTop: 80, flexDirection: 'column', alignItems: 'center' }}>
            <View>
              <TouchableOpacity onPress={() => resetTo(this, 'home')} style={{ backgroundColor: 'grey', borderRadius: 10, padding: 10 }}>
                <Text style={{ color: 'white', fontSize: 25, textAlign: 'center', marginHorizontal: 30 }}>
                  {i18n.t('home')}
                </Text>
              </TouchableOpacity>
            </View>
          </View>


        </View>

      </View>
    );
  }
}

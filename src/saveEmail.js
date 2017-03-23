import { AsyncStorage } from 'react-native';

export async function saveEmail(email) {
  let result = {};
  try {
    const uuid = await AsyncStorage.getItem('uuid');
    result = {
      'resultId': uuid,
      'email': email,
    };
    console.log('outgoing data is', result);
  } catch (err) {
    console.log('get uuid error', err);
  }


  try {
    const response = await fetch('https://mchatrest.otsimo.xyz/addUserInfo ', {
      method: 'POST',
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(result),
    });
    console.log('response', response);
  } catch (err) {
    console.log('sending failed', err);
  }
}

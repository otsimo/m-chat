export async function SaveToServer(result) {
  const Info = {
    birthDay: 1,
    gender: '2',
    relation: '3',
  };

  const DeviceInfo = {
    vendorId: '1',
    bundleIdentifier: '3',
    bundleVersion: '4',
    bundleShortVersion: '5',
    deviceType: '6',
    deviceName: '7',
    osName: '8',
    systemVersion: '9',
    languageCode: '10',
    countryCode: '11',
    ip: '12',
  };

  const StepResult = {
    id: '1',
  };

  const Result = {
    info: Info,
    device: DeviceInfo,
    duration: 3,
    version: 1,
  };

  try {
    const response = await fetch('https://mchatrest.otsimo.xyz/addResult', {
      method: 'POST',
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(Result),
    });
    console.log('response', response);
  } catch (err) {
    console.log('sending failed', err);
  }
}

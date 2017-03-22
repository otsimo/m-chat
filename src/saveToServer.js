


export async function SaveToServer(result) {
  try {
    const response = await fetch('https://mchatrest.otsimo.xyz/addResult', {
      method: 'POST',
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(result),
    });
    console.log('response', response);
    return true;
  } catch (err) {
    console.log('sending failed', err);
    return false;
  }
}

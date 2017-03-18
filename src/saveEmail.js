export async function saveEmail(result) {
  try {
    const response = await fetch('https://mchatrest.otsimo.xyz/', {
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

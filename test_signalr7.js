const fs = require('fs');
const http = require('https');
const { FormData, File } = require('formdata-node') || {};

async function main() {
  const signalR = await import('@microsoft/signalr');
  
  const fd = new FormData();
  fd.append("FullName", "Test User");
  fd.append("Email", `test_signalr_${Date.now()}@example.com`);
  fd.append("Password", "Password123!");
  fd.append("NationalId", `12345678901234`);
  
  // create dummy image file
  const dummyBuffer = Buffer.from('dummy image data');
  fd.append("IdCardImage", new File([dummyBuffer], "dummy.png", { type: "image/png" }));
  
  const res = await fetch('https://rentalplatform.runasp.net/api/Account/register', {
    method: 'POST',
    body: fd
  });
  
  console.log('Register response:', res.status);
  const text = await res.text();
  console.log('Register body:', text);
  
  if (res.status !== 200 && res.status !== 201) return;
  
  const data = JSON.parse(text);
  const token = data.token || data.data?.token;
  if (!token) {
    console.log('No token found');
    return;
  }
  
  console.log('Connecting to SignalR...');
  const connection = new signalR.HubConnectionBuilder()
    .withUrl('https://rentalplatform.runasp.net/chatHub', {
      accessTokenFactory: () => token
    })
    .configureLogging(signalR.LogLevel.Trace)
    .build();

  try {
    await connection.start();
    console.log('Connected!');

    try {
      console.log('Invoking CreateOrGetConversation...');
      const res1 = await connection.invoke('CreateOrGetConversation', 'seller123', 1);
      console.log('CreateOrGetConversation result:', res1);
    } catch (e) {
      console.error('CreateOrGetConversation failed:', e.message);
    }

    try {
      console.log('Invoking SendMessage...');
      const res2 = await connection.invoke('SendMessage', 1, 'hello');
      console.log('SendMessage result:', res2);
    } catch (e) {
      console.error('SendMessage failed:', e.message);
    }

    await connection.stop();
  } catch (e) {
    console.error('Connection failed:', e.message);
  }
}

main().catch(console.error);

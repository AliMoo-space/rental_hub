const fs = require('fs');
const http = require('https');
const { FormData } = require('formdata-node') || {};

async function main() {
  const signalR = await import('@microsoft/signalr');
  
  // Actually, I can use fetch because NodeJS >= 18 has fetch!
  const fd = new FormData();
  fd.append("firstName", "Test");
  fd.append("lastName", "User");
  fd.append("email", `test_signalr_${Date.now()}@example.com`);
  fd.append("password", "Password123!");
  fd.append("phoneNumber", `010${String(Date.now()).substring(0, 8)}`);
  fd.append("role", "User");
  
  const res = await fetch('https://rentalplatform.runasp.net/api/Authentication/register', {
    method: 'POST',
    body: fd
  });
  
  console.log('Register response:', res.status);
  const data = await res.json();
  console.log('Register body:', data);
  
  if (res.status !== 200 && res.status !== 201) return;
  
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

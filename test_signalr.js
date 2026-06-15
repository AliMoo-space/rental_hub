const fs = require('fs');
const http = require('https');

async function main() {
  const signalR = await import('@microsoft/signalr');
  
  const payload = JSON.stringify({
    "firstName": "Test",
    "lastName": "User",
    "email": `test_signalr_${Date.now()}@example.com`,
    "password": "Password123!",
    "phoneNumber": `010${String(Date.now()).substring(0, 8)}`,
    "role": "User"
  });

  const options = {
    hostname: 'rentalplatform.runasp.net',
    port: 443,
    path: '/api/Account/register',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': payload.length
    }
  };

  const req = http.request(options, (res) => {
    let data = '';
    res.on('data', (chunk) => data += chunk);
    res.on('end', async () => {
      console.log('Register response:', res.statusCode, data);
      if (res.statusCode !== 200 && res.statusCode !== 201) return;
      
      const json = JSON.parse(data);
      const token = json.token || json.data?.token;
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
    });
  });

  req.write(payload);
  req.end();
}

main().catch(console.error);

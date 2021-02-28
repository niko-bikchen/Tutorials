const fs = require('fs');

function requestHandler(request, response) {
  const url = request.url;
  const method = request.method;

  if (url === '/') {
    response.setHeader('Content-Type', 'text/html');
    response.write('<html>');
    response.write('<head><title>My Form</title></head>');
    response.write('<body>');
    response.write(`
            <div style="text-align: center; margin-top: 20%;">
              <form action="/message" method="POST">
                <input type="text" placeholder="Input something!" name="message">
                <button type="submit">Submit!</button>
              </form>
            </div>
          `);
    response.write('</body>');
    response.write('</html>');
    response.end();
  } else if (url === '/message' && method === 'POST') {
    const body = [];

    request.on('data', function processChunk(chunk) {
      body.push(chunk);
    });
    request.on('end', function wrapUp() {
      const parsedBody = Buffer.concat(body).toString();
      const message = parsedBody.split('=')[1];
      fs.writeFile('./message.txt', message, function handleError(err) {
        // response.statusCode = 302;
        // response.setHeader('Location', '/');
        response.writeHead(302, {
          Location: '/',
        });
        response.end();
      });
    });
  } else {
    response.setHeader('Content-Type', 'text/html');
    response.write('<html>');
    response.write('<head><title>My First Page</title></head>');
    response.write('<body><h1>Hello form from my Node.js server!</h1></body>');
    response.write('</html>');
    response.end();
  }
}

module.exports = requestHandler;

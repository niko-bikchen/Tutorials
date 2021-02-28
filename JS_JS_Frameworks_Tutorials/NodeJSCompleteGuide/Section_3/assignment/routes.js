const fs = require('fs');

function sendHTMLDocumentWithBody(response, pageTitle, bodyContents) {
  response.setHeader('Content-Type', 'text/html');
  response.write('<html>');
  response.write(`<head><title>${pageTitle}</title></head>`);
  response.write(`<body>${bodyContents}</body>`);
  response.write('</html>');
  response.end();
}

function redirect(response, destination) {
  response.statusCode = 302;
  response.setHeader('Location', destination);
  response.end();
}

function handleRequests(request, response) {
  const URL = request.url;
  const METHOD = request.method;

  const MAIN_PAGE = '/';
  const USERS_PAGE = '/users';
  const NEW_USER_ENDPOINT = '/create-user';

  const CENTER_ELEMENT =
    'position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);';
  const DEFAULT_USERS = ['Bob', 'Cooler Bob'];

  if (URL === MAIN_PAGE && METHOD === 'GET') {
    sendHTMLDocumentWithBody(
      response,
      'Main Page',
      `
      <div style="${CENTER_ELEMENT}">
        <div style="text-align: center;">
          <a href="${USERS_PAGE}">Users</a>
        </div>
        <h1 style="text-align: center;">
          Hello!
        </h1>
        <form action="${NEW_USER_ENDPOINT}" method="POST">
          <input name="usernames" type="text" placeholder="Username">
          <button type="submit">Add New User</button>
        </form>
      </div>
    `
    );
  } else if (URL === USERS_PAGE && METHOD === 'GET') {
    fs.readFile('./users.txt', 'utf8', function (err, contents) {
      const users = contents.split(';').filter((user) => user !== '');
      let usersList = '';

      if (users.length > 0) {
        usersList = [...DEFAULT_USERS, ...users].map((user) => `<li>${user}</li>`).join('');
      } else {
        usersList = DEFAULT_USERS.map((user) => `<li>${user}</li>`).join('');
      }

      sendHTMLDocumentWithBody(
        response,
        'Users List',
        `
        <div style="${CENTER_ELEMENT}">
          <div style="text-align: center;">
            <a href="${MAIN_PAGE}">Main Page</a>
          </div>
          <h1 style="text-align: center;">
            User List
          </h1>
          <ul>
            ${usersList}
          </ul>
        </div>
      `
      );
    });
  } else if (URL === NEW_USER_ENDPOINT && METHOD === 'POST') {
    let requestBody = [];

    request.on('data', function processChunk(chunk) {
      requestBody.push(chunk);
    });

    request.on('end', function saveNewUser() {
      const parsedBody = Buffer.concat(requestBody).toString();
      const newUser = parsedBody.split('=')[1];

      console.log(`NEW USER: ${newUser}`);

      fs.appendFile('./users.txt', newUser + ';', function onWriteComplete() {
        redirect(response, '/');
      });
    });
  } else {
    redirect(response, '/');
  }
}

module.exports = handleRequests;

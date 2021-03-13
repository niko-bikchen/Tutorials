const http = require('http');
const fs = require('fs');

fs.writeFileSync('./users.txt', '');

const routes = require('./routes');

const SERVER = http.createServer(routes);

SERVER.listen(3000);

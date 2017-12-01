"use strict";

const stdin = process.stdin;

stdin.resume();
stdin.setEncoding('utf8');

stdin.on('data', function (data) {
  data = data.replace(/^\s+|\s+$/, '');

  const size = data.length;

  let sum = 0;

  for (let i = 0; i < data.length; i++) {
    let next = i + (size / 2);

    if (next >= size) {
      next = next % size;
    }

    if (data[i] === data[next]) {
      sum += parseInt(data[i]);
    }
  }

  console.log(sum);
});

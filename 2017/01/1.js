"use strict";

const stdin = process.stdin;

stdin.resume();
stdin.setEncoding('utf8');

stdin.on('data', function (data) {
  data = data.replace(/^\s+|\s+$/, '');

  const size = data.length;

  let sum = 0;

  for (let i = 0; i < size; i++) {
    let next = i + 1;

    if (next >= size) {
      next = next % size;
    }

    if (data[i] === data[next]) {
      sum += parseInt(data[i], 10);
    }
  }

  console.log(sum);
});

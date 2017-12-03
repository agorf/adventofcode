"use strict";

const stdin = process.stdin;

stdin.resume();
stdin.setEncoding('utf8');

stdin.on('data', function (data) {
  const input = parseInt(data.replace(/^\s+|\s+$/, ''), 10);

  if (input === 1) {
    console.log(1);
    return;
  }

  for (let square = 1; ; square++) {
    const min = Math.pow(2 * (square - 1) + 1, 2) + 1;
    const max = Math.pow(2 * square + 1, 2);

    if (input < min || input > max) {
      continue;
    }

    const i = (input - min) % (2 * square);
    const distance = square + Math.abs(square - i - 1);
    console.log(distance);
    break;
  }
});

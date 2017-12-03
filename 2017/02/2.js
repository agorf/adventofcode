"use strict";

const stdin = process.stdin;

stdin.resume();
stdin.setEncoding('utf8');

stdin.on('data', function (data) {
  data = data.replace(/^\s+|\s+$/, '');

  const sum = data.split("\n").reduce((sum, line) => {
    const row = line.split(/\s+/).map((n) => parseInt(n, 10));

    for (let i = 0; i < row.length; i++) {
      for (let j = 0; j < row.length; j++) {
        if (i === j) {
          continue;
        }

        if (row[i] % row[j] === 0) {
          return sum + (row[i] / row[j]);
        }

        if (row[j] % row[i] === 0) {
          return sum + (row[j] / row[i]);
        }
      }
    }
  }, 0);

  console.log(sum);
});

"use strict";

const stdin = process.stdin;

stdin.resume();
stdin.setEncoding('utf8');

stdin.on('data', function (data) {
  data = data.replace(/^\s+|\s+$/, '');

  const sum = data.split("\n").reduce((sum, line) => {
    const row = line.split(/\s+/).map((n) => parseInt(n, 10));
    const max = row.reduce((max, n) => Math.max(max, n));
    const min = row.reduce((min, n) => Math.min(min, n));
    const checksum = max - min;

    return sum + checksum;
  }, 0);

  console.log(sum);
});

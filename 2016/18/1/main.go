package main

import (
	"fmt"
	"strings"
)

const rows = 40

func main() {
	var line string

	fmt.Scanln(&line)

	width := len(line)
	safeTiles := strings.Count(line, ".")

	for i := 1; i < rows; i++ {
		buf := make([]byte, width)

		for j := 0; j < width; j++ {
			leftSafe := j-1 < 0 || line[j-1] == '.'
			centerSafe := line[j] == '.'
			rightSafe := j+1 >= width || line[j+1] == '.'

			trap := (!leftSafe && !centerSafe && rightSafe) || (leftSafe && !centerSafe && !rightSafe) || (!leftSafe && centerSafe && rightSafe) || (leftSafe && centerSafe && !rightSafe)

			if trap {
				buf[j] = '^'
			} else {
				buf[j] = '.'
				safeTiles++
			}
		}

		line = string(buf)
	}

	fmt.Println(safeTiles)
}

package main

import (
	"bytes"
	"fmt"
	"regexp"
)

func main() {
	var buffer bytes.Buffer
	var data string
	var length, times int

	if _, err := fmt.Scanln(&data); err != nil {
		panic(err)
	}

	re := regexp.MustCompile("\\([0-9]+x[0-9]+\\)")

	start := 0

	for {
		loc := re.FindStringIndex(data[start:])

		if len(loc) == 0 {
			break
		}

		buffer.WriteString(data[0 : start+loc[0]])

		match := data[start+loc[0] : start+loc[1]]

		if _, err := fmt.Sscanf(match, "(%dx%d)", &length, &times); err != nil {
			panic(err)
		}

		repeatedStr := data[start+loc[1] : start+loc[1]+length]

		for i := 0; i < times; i++ {
			buffer.WriteString(repeatedStr)
		}

		oldStart := start
		start = len(buffer.String())

		buffer.WriteString(data[oldStart+loc[1]+length:])

		data = buffer.String()

		buffer.Reset()

		if start > len(data) {
			break
		}
	}

	fmt.Println(len(data))
}

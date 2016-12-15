package main

import (
	"fmt"
	"regexp"
)

func main() {
	var data string

	if _, err := fmt.Scanln(&data); err != nil {
		panic(err)
	}

	fmt.Println(decompressedLength(data))
}

func decompressedLength(str string) (length int) {
	var markerLength, markerTimes int

	re := regexp.MustCompile("\\([0-9]+x[0-9]+\\)")
	start := 0

	for {
		loc := re.FindStringIndex(str[start:])

		if len(loc) == 0 {
			length += len(str[start:])
			return
		}

		length += loc[0]

		if _, err := fmt.Sscanf(str[start+loc[0]:start+loc[1]], "(%dx%d)", &markerLength, &markerTimes); err != nil {
			panic(err)
		}

		length += markerTimes * decompressedLength(str[start+loc[1]:start+loc[1]+markerLength])
		start += loc[1] + markerLength

		if start == len(str) {
			return
		}

	}

	return
}

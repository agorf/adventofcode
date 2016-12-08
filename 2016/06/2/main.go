package main

import (
	"bufio"
	"fmt"
	"os"
)

const messageLen = 8

func main() {
	var freqByCol [messageLen]map[byte]int
	var message [messageLen]byte

	for i := 0; i < len(freqByCol); i++ {
		freqByCol[i] = make(map[byte]int)
	}

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := scanner.Text()

		for i := 0; i < len(line); i++ {
			freqByCol[i][line[i]]++
		}
	}

	for i := 0; i < len(freqByCol); i++ {
		var minChar byte

		minCount := int(^uint(0) >> 1) // max int value

		for char, count := range freqByCol[i] {
			if count < minCount {
				minCount = count
				minChar = char
			}
		}

		message[i] = minChar
	}

	fmt.Println(string(message[:len(message)]))
}

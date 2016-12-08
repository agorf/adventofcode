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
		var maxChar byte

		maxCount := 0

		for char, count := range freqByCol[i] {
			if count > maxCount {
				maxCount = count
				maxChar = char
			}
		}

		message[i] = maxChar
	}

	fmt.Println(string(message[:len(message)]))
}

package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	var instructions [][]string
	var regs [4]int
	var x, y int
	var err error

	regs['c'-'a'] = 1

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		words := strings.Fields(scanner.Text())
		instructions = append(instructions, words)
	}

	for i := 0; i < len(instructions); i++ {
		if i < 0 || i >= len(instructions) {
			break
		}

		words := instructions[i]

		switch words[0] {
		case "cpy":
			if x, err = strconv.Atoi(words[1]); err != nil { // a register
				x = regs[words[1][0]-'a'] // get value from register
			}

			regs[words[2][0]-'a'] = x
		case "inc":
			regs[words[1][0]-'a']++
		case "dec":
			regs[words[1][0]-'a']--
		case "jnz":
			if x, err = strconv.Atoi(words[1]); err != nil { // a register
				x = regs[words[1][0]-'a'] // get value from register
			}

			if x != 0 {
				if y, err = strconv.Atoi(words[2]); err != nil {
					panic(err)
				}

				i += y - 1 // -1 to cancel out i++ in for loop
			}
		}
	}

	fmt.Println(regs[0])
}

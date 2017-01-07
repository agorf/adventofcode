package main

import (
	"bufio"
	"bytes"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type Password []byte

func main() {
	var operations []string

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		operation := scanner.Text()
		operations = append(operations, operation)
	}

	for p := Password("abcdefgh"); ; p.Permute() {
		password := Password(p.String())
		password.Scramble(operations)

		if password.String() == "fbgdceah" {
			fmt.Println(p)
			break
		}
	}
}

// Produces next permutation in lexicographical order
// https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order
func (p Password) Permute() {
	var l int

	length := len(p)

	k := -1

	for i := length - 2; i >= 0; i-- {
		if p[i] < p[i+1] {
			k = i
			break
		}
	}

	if k == -1 {
		return // no other permutations exist
	}

	for i := length - 1; i > k; i-- {
		if p[k] < p[i] {
			l = i
			break
		}
	}

	p[k], p[l] = p[l], p[k]

	for i := k + 1; i <= k+((length-k)/2); i++ {
		p[i], p[length-i+k] = p[length-i+k], p[i]
	}
}

func (p Password) Scramble(operations []string) {
	opsCount := len(operations)

	for i := 0; i < opsCount; i++ {
		words := strings.Fields(operations[i])

		switch words[0] {
		case "swap":
			if words[1] == "position" {
				x, _ := strconv.Atoi(words[2])
				y, _ := strconv.Atoi(words[5])
				p.SwapPositions(x, y)
			} else if words[1] == "letter" {
				x := words[2][0]
				y := words[5][0]
				p.SwapLetters(x, y)
			}
		case "rotate":
			if words[1] == "based" {
				x := words[6][0]
				p.RotatePosition(x)
			} else if words[1] == "left" {
				steps, _ := strconv.Atoi(words[2])
				p.RotateLeft(steps)
			} else if words[1] == "right" {
				steps, _ := strconv.Atoi(words[2])
				p.RotateRight(steps)
			}
		case "reverse":
			x, _ := strconv.Atoi(words[2])
			y, _ := strconv.Atoi(words[4])
			p.ReverseSpan(x, y)
		case "move":
			x, _ := strconv.Atoi(words[2])
			y, _ := strconv.Atoi(words[5])
			p.MovePosition(x, y)
		}
	}
}

func (p Password) String() string {
	return string(p)
}

func (p Password) SwapPositions(x, y int) {
	p[x], p[y] = p[y], p[x]
}

func (p Password) SwapLetters(x, y byte) {
	length := len(p)

	for i := 0; i < length; i++ {
		if p[i] == x {
			p[i] = y
		} else if p[i] == y {
			p[i] = x
		}
	}
}

func (p Password) RotateLeft(steps int) {
	length := len(p)
	steps = steps % length

	for i := 0; i < steps; i++ {
		first := p[0]

		for j := 0; j+1 < length; j++ {
			p[j] = p[j+1]
		}

		p[len(p)-1] = first
	}
}

func (p Password) RotateRight(steps int) {
	length := len(p)
	steps = steps % length

	for i := 0; i < steps; i++ {
		last := p[length-1]

		for j := length - 1; j > 0; j-- {
			p[j] = p[j-1]
		}

		p[0] = last
	}

}

func (p Password) RotatePosition(x byte) {
	steps := bytes.IndexByte(p, x)

	if steps >= 4 {
		steps++
	}

	steps++

	p.RotateRight(steps)
}

func (p Password) ReverseSpan(x, y int) {
	until := x + ((y - x - 1) / 2)

	for i := x; i <= until; i++ {
		p[i], p[y-(i-x)] = p[y-(i-x)], p[i]
	}
}

func (p Password) MovePosition(x, y int) {
	letter := p[x]
	length := len(p)

	// shift text [x+1, len(p)-1] 1 position left to consume space of x
	for i := x; i+1 < length; i++ {
		p[i] = p[i+1]
	}

	// shift text [y, len(p)-2] 1 position right to make space for x
	for i := length - 1; i > y; i-- {
		p[i] = p[i-1]
	}

	p[y] = letter // write value of x to y position
}

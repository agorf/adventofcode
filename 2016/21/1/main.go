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
	scanner := bufio.NewScanner(os.Stdin)

	password := Password("abcdefgh")

	for scanner.Scan() {
		line := scanner.Text()
		words := strings.Fields(line)

		switch words[0] {
		case "swap":
			if words[1] == "position" {
				x, _ := strconv.Atoi(words[2])
				y, _ := strconv.Atoi(words[5])
				password.SwapPositions(x, y)
			} else if words[1] == "letter" {
				x := words[2][0]
				y := words[5][0]
				password.SwapLetters(x, y)
			}
		case "rotate":
			if words[1] == "based" {
				x := words[6][0]
				password.RotatePosition(x)
			} else if words[1] == "left" {
				steps, _ := strconv.Atoi(words[2])
				password.RotateLeft(steps)
			} else if words[1] == "right" {
				steps, _ := strconv.Atoi(words[2])
				password.RotateRight(steps)
			}
		case "reverse":
			x, _ := strconv.Atoi(words[2])
			y, _ := strconv.Atoi(words[4])
			password.ReverseSpan(x, y)
		case "move":
			x, _ := strconv.Atoi(words[2])
			y, _ := strconv.Atoi(words[5])
			password.MovePosition(x, y)
		}
	}

	fmt.Println(password)
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

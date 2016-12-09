package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type Screen struct {
	Screen [][]bool
	Width  int
	Height int
}

func main() {
	var width, height, row, col, by int
	var err error

	screen := Screen{nil, 50, 6}
	screen.Initialize()

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		words := strings.Fields(scanner.Text())

		if words[0] == "rect" {
			if _, err := fmt.Sscanf(words[1], "%dx%d", &width, &height); err != nil {
				panic(err)
			}

			screen.DrawRect(width, height)
		} else if words[0] == "rotate" {
			if words[1] == "row" {
				if _, err := fmt.Sscanf(words[2], "y=%d", &row); err != nil {
					panic(err)
				}

				if by, err = strconv.Atoi(words[4]); err != nil {
					panic(err)
				}

				screen.ShiftRow(row, by)
			} else if words[1] == "column" {
				if _, err := fmt.Sscanf(words[2], "x=%d", &col); err != nil {
					panic(err)
				}

				if by, err = strconv.Atoi(words[4]); err != nil {
					panic(err)
				}

				screen.ShiftCol(col, by)
			}
		}
	}

	screen.Print()
}

func (screen *Screen) Initialize() {
	screen.Screen = make([][]bool, screen.Height)

	for i := 0; i < screen.Height; i++ {
		screen.Screen[i] = make([]bool, screen.Width)
	}
}

func (screen Screen) Print() {
	for i := 0; i < screen.Height; i++ {
		for j := 0; j < screen.Width; j++ {
			if screen.Screen[i][j] {
				fmt.Print("#")
			} else {
				fmt.Print(".")
			}
		}

		fmt.Println()
	}
}

func (screen *Screen) DrawRect(width, height int) {
	for i := 0; i < height; i++ {
		for j := 0; j < width; j++ {
			screen.Screen[i][j] = true
		}
	}
}

func (screen *Screen) ShiftRow(row, by int) {
	for i := 0; i < by; i++ {
		back := screen.Screen[row][screen.Width-1] // remember right-most pixel

		for j := screen.Width - 1; j > 0; j-- {
			screen.Screen[row][j] = screen.Screen[row][j-1]
		}

		screen.Screen[row][0] = back
	}
}

func (screen *Screen) ShiftCol(col, by int) {
	for i := 0; i < by; i++ {
		back := screen.Screen[screen.Height-1][col] // remember bottom pixel

		for j := screen.Height - 1; j > 0; j-- {
			screen.Screen[j][col] = screen.Screen[j-1][col]
		}

		screen.Screen[0][col] = back
	}
}

package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	var err error

	scanner := bufio.NewScanner(os.Stdin)
	fields := [3][]string{}
	edges := [3][3]int{}
	possible := 0
	i := 0

	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		fields[i] = strings.Fields(line)

		for j := 0; j < 3; j++ {
			if edges[i][j], err = strconv.Atoi(fields[i][j]); err != nil {
				panic(err)
			}
		}

		if i == 2 {
			for j := 0; j < 3; j++ {
				if validTriangle(edges[0][j], edges[1][j], edges[2][j]) {
					possible++
				}
			}
		}

		i = (i + 1) % 3
	}

	if err = scanner.Err(); err != nil {
		panic(err)
	}

	fmt.Println(possible)
}

func validTriangle(a, b, c int) bool {
	return a+b > c && a+c > b && b+c > a
}

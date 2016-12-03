package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	var a, b, c int
	var err error

	scanner := bufio.NewScanner(os.Stdin)
	possible := 0

	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		fields := strings.Fields(line)

		if a, err = strconv.Atoi(fields[0]); err != nil {
			panic(err)
		}

		if b, err = strconv.Atoi(fields[1]); err != nil {
			panic(err)
		}

		if c, err = strconv.Atoi(fields[2]); err != nil {
			panic(err)
		}

		if a+b > c && a+c > b && b+c > a {
			possible++
		}
	}

	if err = scanner.Err(); err != nil {
		panic(err)
	}

	fmt.Println(possible)
}

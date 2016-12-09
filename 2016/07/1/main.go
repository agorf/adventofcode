package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	count := 0

	for scanner.Scan() {
		if ipAddressSupportsTLS(scanner.Text()) {
			count++
		}
	}

	fmt.Println(count)
}

func ipAddressSupportsTLS(address string) bool {
	var re *regexp.Regexp
	var err error

	if re, err = regexp.Compile("[a-z]+"); err != nil {
		panic(err)
	}

	res := re.FindAllString(address, -1)
	tls := false

	for i := 0; i < len(res); i++ {
		if i%2 == 1 { // hypernet sequence
			if containsABBA(res[i]) {
				return false
			}
		} else if containsABBA(res[i]) {
			tls = true
		}
	}

	return tls
}

func containsABBA(str string) bool {
	for i := 0; i < len(str)-3; i++ {
		if str[i] == str[i+3] && str[i+1] == str[i+2] && str[i] != str[i+1] {
			return true
		}
	}

	return false
}

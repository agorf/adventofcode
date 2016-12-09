package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strings"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	count := 0

	for scanner.Scan() {
		if ipAddressSupportsSSL(scanner.Text()) {
			count++
		}
	}

	fmt.Println(count)
}

func ipAddressSupportsSSL(address string) bool {
	var re *regexp.Regexp
	var err error

	if re, err = regexp.Compile("[a-z]+"); err != nil {
		panic(err)
	}

	seqs := re.FindAllString(address, -1)

	for i := 0; i < len(seqs); i += 2 {
		superSeq := seqs[i]

		for j := 0; j < len(superSeq)-2; j++ {
			aba := superSeq[j : j+3]

			if aba[0] != aba[2] || aba[0] == aba[1] { // not really an aba
				continue
			}

			for k := 1; k < len(seqs); k += 2 {
				hyperSeq := seqs[k]

				if strings.Contains(hyperSeq, babForAba(aba)) {
					return true
				}
			}
		}
	}

	return false
}

func babForAba(aba string) string {
	bab := [3]byte{aba[1], aba[0], aba[1]}

	return string(bab[:len(bab)])
}

package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

type ByFreq []byte

var freq map[byte]int

func (s ByFreq) Less(i, j int) bool {
	if freq[s[i]] == freq[s[j]] {
		return s[i] < s[j]
	}

	return freq[s[i]] > freq[s[j]]
}

func (s ByFreq) Len() int {
	return len(s)
}

func (s ByFreq) Swap(i, j int) {
	s[i], s[j] = s[j], s[i]
}

func main() {
	var err error

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := scanner.Text()

		dashIndex := strings.LastIndex(line, "-")
		bracketIndex := strings.Index(line, "[")

		name := line[0:dashIndex]
		sectorIdStr := line[dashIndex+1 : bracketIndex]
		checksum := line[bracketIndex+1 : len(line)-1]

		if isRealRoom(name, checksum) {
			sectorId := 0
			if sectorId, err = strconv.Atoi(sectorIdStr); err != nil {
				panic(err)
			}

			if decryptRoom(name, sectorId) == "northpole object storage" {
				fmt.Println(sectorId)
			}
		}
	}
}

func isRealRoom(name, checksum string) bool {
	return roomChecksum(name)[0:len(checksum)] == checksum
}

func roomChecksum(name string) string {
	freq = make(map[byte]int)

	for i := 0; i < len(name); i++ {
		if name[i] != "-"[0] {
			freq[name[i]]++
		}
	}

	checksum := make([]byte, len(freq))
	i := 0

	for key, _ := range freq {
		checksum[i] = key
		i++
	}

	sort.Sort(ByFreq(checksum))

	return string(checksum)
}

func decryptRoom(name string, shift int) string {
	decryptedName := make([]byte, len(name))
	byteShift := byte(shift % 26)

	for i := 0; i < len(name); i++ {
		if name[i] == "-"[0] {
			decryptedName[i] = " "[0]
		} else {
			decryptedName[i] = "a"[0] + ((name[i] - "a"[0] + byteShift) % 26)
		}
	}

	return string(decryptedName)
}

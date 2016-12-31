package main

import (
	"crypto/md5"
	"fmt"
	"strconv"
	"strings"
)

const salt = "ngcjuoqr"
const targetKeys = 64

var hashCache map[string]string

func main() {
	hashCache = make(map[string]string)

	keys := 0

	for i := 0; ; i++ {
		if indexProducesKey(i) {
			keys++

			if keys == targetKeys {
				fmt.Println(i)
				break
			}
		}
	}
}

func md5Hash(str string) string {
	if hash, ok := hashCache[str]; ok {
		return hash
	}

	hash := fmt.Sprintf("%x", md5.Sum([]byte(str)))
	hashCache[str] = hash

	return hash
}

func firstTripletIndex(str string) int {
	for i := 0; i < len(str)-2; i++ {
		if str[i] == str[i+1] && str[i+1] == str[i+2] {
			return i
		}
	}

	return -1
}

func indexProducesKey(index int) bool {
	hash := md5Hash(saltWithIndex(index))
	triplet := firstTripletIndex(hash)

	if triplet == -1 {
		return false
	}

	repeatedStr := string(hash[triplet])
	substr := strings.Repeat(repeatedStr, 5)

	for i := index + 1; i < index+1000; i++ {
		if strings.Contains(md5Hash(saltWithIndex(i)), substr) {
			return true
		}
	}

	return false
}

func saltWithIndex(index int) string {
	return salt + strconv.Itoa(index)
}

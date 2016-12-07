package main

import (
	"crypto/md5"
	"fmt"
	"strconv"
	"strings"
)

func main() {
	var doorId string
	var password [8]byte
	var i, len int

	fmt.Scanln(&doorId)

	for len < 8 {
		hash := md5Hash(doorId + strconv.Itoa(i))

		if strings.HasPrefix(hash, "00000") {
			password[len] = hash[5]
			len++
		}

		i++
	}

	fmt.Println(string(password[:len]))
}

func md5Hash(str string) string {
	return fmt.Sprintf("%x", md5.Sum([]byte(str)))
}

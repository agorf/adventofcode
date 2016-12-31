package main

import (
	"bytes"
	"fmt"
)

const initialState = "01111001100111011" // input
const diskLength = 272

func main() {
	data := generateRandomData(initialState, diskLength)[:diskLength]
	fmt.Println(calculateChecksum(data))
}

func generateRandomData(initialState string, minLen int) string {
	var data bytes.Buffer

	data.WriteString(initialState)

	for data.Len() < minLen {
		a := data.String()
		b := invertOnesAndZeros(reverseString(a))
		data.WriteString("0")
		data.WriteString(b)
	}

	return data.String()
}

func reverseString(str string) string {
	size := len(str)
	buf := make([]byte, size)

	for i := 0; i < size; i++ {
		buf[size-i-1] = str[i]
	}

	return string(buf)
}

func invertOnesAndZeros(str string) string {
	size := len(str)
	buf := make([]byte, size)

	for i := 0; i < size; i++ {
		if str[i] == '0' {
			buf[i] = '1'
		} else if str[i] == '1' {
			buf[i] = '0'
		} else {
			buf[i] = str[i]
		}
	}

	return string(buf)
}

func calculateChecksum(str string) string {
	size := len(str)

	if size%2 != 0 {
		panic("string length is not even")
	}

	buf := make([]byte, size/2)

	for i := 0; i < size/2; i++ {
		if str[i*2] == str[i*2+1] {
			buf[i] = '1'
		} else {
			buf[i] = '0'
		}
	}

	if (size/2)%2 == 0 { // even
		return calculateChecksum(string(buf))
	}

	return string(buf)
}

package main

import "fmt"

type Elf struct {
	Number   int
	Presents int
	Next     *Elf
}

const elves = 3014603 // input

func main() {
	var head, tail *Elf

	for i := elves; i > 0; i-- {
		elf := Elf{i, 1, head}

		if head == nil {
			tail = &elf
		}

		head = &elf
	}

	tail.Next = head // close circle

	for p := head; ; p = p.Next {
		p.Presents += p.Next.Presents // take next elf's presents

		if p.Presents == elves { // elf has all presents
			fmt.Println(p.Number)
			break
		}

		p.Next = p.Next.Next // skip next elf with no presents
	}
}

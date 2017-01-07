package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
)

type RangeSorter [][2]int

func (r RangeSorter) Len() int {
	return len(r)
}

func (r RangeSorter) Swap(i, j int) {
	r[i], r[j] = r[j], r[i]
}

func (r RangeSorter) Less(i, j int) bool {
	if r[i][0] == r[j][0] {
		return r[i][1] < r[j][1]
	}

	return r[i][0] < r[j][0]
}

const first = 0
const last = 4294967295

func main() {
	var from, to int
	var ranges [][2]int

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := scanner.Text()
		fmt.Sscanf(line, "%d-%d", &from, &to)
		ranges = append(ranges, [2]int{from, to})
	}

	sort.Sort(RangeSorter(ranges))

	allowed := 0
	maxSeen := first

	for i := 0; i < len(ranges); i++ {
		from, to = ranges[i][0], ranges[i][1]

		if from > maxSeen+1 {
			allowed += from - maxSeen - 1
		}

		if to > maxSeen {
			maxSeen = to
		}
	}

	if last > maxSeen+1 {
		allowed += last - maxSeen
	}

	fmt.Println(allowed)
}

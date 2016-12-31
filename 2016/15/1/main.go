package main

import (
	"bufio"
	"fmt"
	"os"
)

type Disc struct {
	Positions, InitialPosition, CurrentPosition int
}

func (d Disc) OnSlot() bool {
	return d.CurrentPosition == 0
}

func (d *Disc) Tick(time int) {
	d.CurrentPosition = (d.CurrentPosition + time) % d.Positions
}

func (d *Disc) Reset() {
	d.CurrentPosition = d.InitialPosition
}

func main() {
	var disc, positions, position int
	var discs []Disc

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := scanner.Text()

		if _, err := fmt.Sscanf(line, "Disc #%d has %d positions; at time=0, it is at position %d.", &disc, &positions, &position); err != nil {
			panic(err)
		}

		disc := Disc{positions, position, position}
		discs = append(discs, disc)
	}

	for start := 0; ; start++ {
		for i := 0; i < len(discs); i++ {
			disc := &discs[i]
			time := start + i + 1
			disc.Tick(time)
		}

		aligned := true

		for i := 0; i < len(discs); i++ {
			disc := &discs[i]

			if aligned && !disc.OnSlot() {
				aligned = false
			}

			disc.Reset()
		}

		if aligned {
			fmt.Println(start)
			break
		}
	}
}

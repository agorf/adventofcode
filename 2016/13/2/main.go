package main

import (
	"fmt"
	"strings"
)

type Location struct {
	X, Y int
}

type Job struct {
	Start Location
	Steps int
}

const input = 1364

func main() {
	var newStart Location

	start := Location{1, 1}
	queue := []Job{Job{start, 0}}
	processed := make(map[Location]bool)
	locations := 0

	for len(queue) > 0 {
		// dequeue
		job := queue[0]
		queue = queue[1:]

		if processed[job.Start] {
			continue
		}

		processed[job.Start] = true // mark as seen

		if job.Steps > 50 {
			continue
		}

		locations++

		newStart = Location{job.Start.X - 1, job.Start.Y}
		if isMazeOpen(newStart) {
			queue = append(queue, Job{newStart, job.Steps + 1})
		}

		newStart = Location{job.Start.X, job.Start.Y - 1}
		if isMazeOpen(newStart) {
			queue = append(queue, Job{newStart, job.Steps + 1})
		}

		newStart = Location{job.Start.X + 1, job.Start.Y}
		if isMazeOpen(newStart) {
			queue = append(queue, Job{newStart, job.Steps + 1})
		}

		newStart = Location{job.Start.X, job.Start.Y + 1}
		if isMazeOpen(newStart) {
			queue = append(queue, Job{newStart, job.Steps + 1})
		}
	}

	fmt.Println(locations)
}

func isMazeOpen(loc Location) bool {
	if loc.X < 0 || loc.Y < 0 {
		return false
	}

	valueBin := fmt.Sprintf("%b", loc.X*loc.X+3*loc.X+2*loc.X*loc.Y+loc.Y+loc.Y*loc.Y+input)

	return strings.Count(valueBin, "1")%2 == 0
}

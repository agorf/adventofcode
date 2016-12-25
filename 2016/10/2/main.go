package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

const empty = -1

type Bot struct {
	Low       int
	High      int
	LowTo     int
	HighTo    int
	LowToBot  bool
	HighToBot bool
}

func (b *Bot) AddValue(value int) {
	if b.Low != empty && b.High != empty {
		panic("trying to set more than two values for bot")
	}

	if b.Low == empty {
		b.Low = value
	} else {
		b.High = value
	}

	if b.Low > b.High {
		b.Low, b.High = b.High, b.Low
	}
}

type Output []int

func main() {
	var err error
	var botId, value int

	bots := make(map[int]*Bot)
	outputs := make(map[int]Output)

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		words := strings.Fields(scanner.Text())

		if words[0] == "bot" {
			if botId, err = strconv.Atoi(words[1]); err != nil {
				panic(err)
			}

			bot, ok := bots[botId]

			if !ok {
				bot = &Bot{empty, empty, empty, empty, true, true}
				bots[botId] = bot
			}

			if bot.LowTo, err = strconv.Atoi(words[6]); err != nil {
				panic(err)
			}

			if bot.HighTo, err = strconv.Atoi(words[11]); err != nil {
				panic(err)
			}

			bot.LowToBot = words[5] == "bot"
			bot.HighToBot = words[10] == "bot"
		} else if words[0] == "value" {
			if value, err = strconv.Atoi(words[1]); err != nil {
				panic(err)
			}

			if botId, err = strconv.Atoi(words[5]); err != nil {
				panic(err)
			}

			bot, ok := bots[botId]

			if !ok {
				bot = &Bot{empty, empty, empty, empty, true, true}
				bots[botId] = bot
			}

			bot.AddValue(value)
		}
	}

	for {
		progressed := false

		for _, bot := range bots {
			if bot.Low == empty || bot.High == empty {
				continue
			}

			if bot.LowTo != empty {
				if bot.LowToBot {
					lowBot := bots[bot.LowTo]
					lowBot.AddValue(bot.Low)
				} else {
					output, ok := outputs[bot.LowTo]

					if ok {
						outputs[bot.LowTo] = append(output, bot.Low)
					} else {
						outputs[bot.LowTo] = Output{bot.Low}
					}
				}

				bot.LowTo = empty

				progressed = true
			}

			if bot.HighTo != empty {
				if bot.HighToBot {
					highBot := bots[bot.HighTo]
					highBot.AddValue(bot.High)
				} else {
					output, ok := outputs[bot.HighTo]

					if ok {
						outputs[bot.HighTo] = append(output, bot.High)
					} else {
						outputs[bot.HighTo] = Output{bot.High}
					}
				}

				bot.HighTo = empty

				progressed = true
			}
		}

		if !progressed {
			break
		}
	}

	product := 1

	for i := 0; i <= 2; i++ {
		output := outputs[i]

		for j := 0; j < len(output); j++ {
			product *= output[j]
		}
	}

	fmt.Println(product)
}

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
	Low     int
	High    int
	LowBot  int
	HighBot int
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

func main() {
	var err error
	var botId, value int

	bots := make(map[int]*Bot)

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		words := strings.Fields(scanner.Text())

		if words[0] == "bot" {
			if botId, err = strconv.Atoi(words[1]); err != nil {
				panic(err)
			}

			bot, ok := bots[botId]

			if !ok {
				bot = &Bot{empty, empty, empty, empty}
				bots[botId] = bot
			}

			if words[5] == "bot" {
				if bot.LowBot, err = strconv.Atoi(words[6]); err != nil {
					panic(err)
				}
			}

			if words[10] == "bot" {
				if bot.HighBot, err = strconv.Atoi(words[11]); err != nil {
					panic(err)
				}
			}
		} else if words[0] == "value" {
			if value, err = strconv.Atoi(words[1]); err != nil {
				panic(err)
			}

			if botId, err = strconv.Atoi(words[5]); err != nil {
				panic(err)
			}

			bot, ok := bots[botId]

			if !ok {
				bot = &Bot{empty, empty, empty, empty}
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

			if bot.LowBot != empty {
				lowBot := bots[bot.LowBot]
				lowBot.AddValue(bot.Low)
				bot.LowBot = empty

				progressed = true
			}

			if bot.HighBot != empty {
				highBot := bots[bot.HighBot]
				highBot.AddValue(bot.High)
				bot.HighBot = empty

				progressed = true
			}
		}

		if !progressed {
			break
		}
	}

	for botId, bot := range bots {
		if bot.Low == 17 && bot.High == 61 {
			fmt.Println(botId)
			break
		}
	}
}

require_relative 'card.rb'

# Poker Hand Evaluation
# TODO: Basically, extend this class (you can create another class, of course!)
class Hand
  attr_reader :cards, :rank

  def initialize(draw_cards)
    @cards = draw_cards.map { |str| Card.new(str) }
    @rank = categorize
  end

  private

  def cards_sort(cards)
    face = []
    5.times do |i|
        if (cards[i].face == :A)
            face.push(14)
        elsif (cards[i].face == :K)
            face.push(13)
        elsif (cards[i].face == :Q)
            face.push(12)
        elsif (cards[i].face == :J)
            face.push(11)
        else
            face.push(cards[i].face)
        end
    end
    face.sort_by!
    if (face[0] == :"10" && face[1] == 11 && face[2] == 12 && face[3] == 13 && face[4] == 14)
        return true
    else
        return false
    end
end

def cards_suit(cards)
    abe = true
    sinzou = 0
    5.times do |i|
        if (i == 0)
            sinzou = cards[0].suit
            next
        end
        if (sinzou != cards[i].suit)
            abe = false
        end
    end
    return abe
end


def card_sort_2(cards)
    card = []
    5.times do |i|
        if (cards[i].face == :A)
            card.push(14)
        elsif (cards[i].face == :K)
            card.push(13)
        elsif (cards[i].face == :Q)
            card.push(12)
        elsif (cards[i].face == :J)
            card.push(11)
        elsif (cards[i].face == :"10")
            card.push(10)
        elsif (cards[i].face == :"9")
            card.push(9)
        elsif (cards[i].face == :"8")
            card.push(8)
        elsif (cards[i].face == :"7")
            card.push(7)
        elsif (cards[i].face == :"6")
            card.push(6)
        elsif (cards[i].face == :"5")
            card.push(5)
        elsif (cards[i].face == :"4")
            card.push(4)
        elsif (cards[i].face == :"3")
            card.push(3)
        elsif (cards[i].face == :"2")
            card.push(2)
        end
    end
    card.sort_by!{|item| item}
    return card
end

def card_sort_3(cards)
    card = []
    5.times do |i|
        if (cards[i].face == :A)
            card.push(1)
        elsif (cards[i].face == :K)
            card.push(13)
        elsif (cards[i].face == :Q)
            card.push(12)
        elsif (cards[i].face == :J)
            card.push(11)
        elsif (cards[i].face == :"10")
            card.push(10)
        elsif (cards[i].face == :"9")
            card.push(9)
        elsif (cards[i].face == :"8")
            card.push(8)
        elsif (cards[i].face == :"7")
            card.push(7)
        elsif (cards[i].face == :"6")
            card.push(6)
        elsif (cards[i].face == :"5")
            card.push(5)
        elsif (cards[i].face == :"4")
            card.push(4)
        elsif (cards[i].face == :"3")
            card.push(3)
        elsif (cards[i].face == :"2")
            card.push(2)
        end
    end
    card.sort_by!{|item| item}
    return card
end

def card_of_three(cards, j)
    abe = card_sort_2(cards)
    3.times do |i|
        if (abe[i] == abe[i + 1] && abe[i] == abe[i + 2])
            if (j == 1)
                if (i == 0 && abe[3] == abe[4])
                    return true
                end
                if (i == 1 && abe[0] == abe[4])
                    return true
                end
                if (i == 2 && abe[0] == abe[1])
                    return true
                end
            else
              return true
            end
        end
    end
    return false
end

def card_of_four(cards)
    abe = card_sort_2(cards)
    2.times do |i|
        if (abe[i] == abe[i + 1] && abe[i] == abe[i + 2] && abe[i] == abe[i + 3])
            return true
        end
    end
    return false
end

def card_of_one(cards, j)
    abe = card_sort_2(cards)
    4.times do |i|
        if (abe[i] == abe[i + 1])
            if (j == 0)
              return true
            else
              if (i == 0 && (abe[2] == abe [3] || abe[3] == abe[4]))
                  return true
              end
              if (i == 1 && (abe[3] == abe [4]))
                  return true
              end
            end
        end
    end
    return false
end

def storate_last_a(cards)
    abe = card_sort_2(cards)
    num = abe[0]
    5.times do |i|
        if (i == 0)
            next
        end
        num += 1
        if (abe[i] != num)
            return false
        end
    end
    return true
end

def storate_first_a(cards)
    abe = card_sort_3(cards)
    num = abe[0]
    5.times do |i|
        if (i == 0)
            next
        end
        num += 1
        if (abe[i] != num)
            return false
        end
    end
    return true
end

  def categorize
    if (cards_sort(cards) && cards_suit(cards))
      return 'royal-straight-flush'
  end
  if (cards_suit(cards) && (storate_last_a(cards) || storate_first_a(cards)))
      return 'straight-flush'
  end
  if (storate_first_a(cards) || storate_last_a(cards))
      return 'straight'
  end
  if (cards_suit(cards))
      return 'flush'
  end
  if (card_of_four(cards))
      return 'four-of-a-kind'
  end
  if (card_of_three(cards, 1))
      return 'full-house'
  end
  if (card_of_three(cards, 0))
      return 'three-of-a-kind'
  end
  if (card_of_one(cards, 1))
      return 'two-pair'
  end
  if (card_of_one(cards, 0))
      return 'one-pair'
  end
return 'high-card'
  end
end

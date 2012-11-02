class Trie
  attr_accessor :board, :boardordered, :boardrepeats

  def initialize
    @root = {}
  end

  def build(string)
    node = @root
    string.chars.sort.each do |char|
      node[char] ||= {}
      node = node[char]
    end
    
    node[:words] ||= []
    node[:words] << string
  end

  def words(wordordered)
    word = wordordered.chars.sort.join
    node = @root
    word.chars.each do |char|
      return false if node.nil?
      node = node[char]
    end
    
    node[:words]
  end
  
  def word_matches? word
    used = {}
    
    word_ok = true
    word.each_char do |ch|
      chs = ch.to_sym
      found = self.boardrepeats[chs]
      if found
        if used[chs]
          if used[chs]+1 > self.boardrepeats[chs]
            word_ok = false
          else
            used[chs] += 1
          end
        else
          used[chs] = 1
        end
      else
        word_ok = false
      end
      break unless word_ok
    end
    
    word_ok
    
  end
  
  def solve_subnode node, word
    words = []
    words.concat node[:words] if node[:words]
    
    matched = true
    
    node.each do |key, subnode|
      if key != :words
        new_word = word + key
        matched = word_matches?(new_word)
        words.concat solve_subnode(subnode, new_word) if matched
      end
    end
    words
  end

  def solve(board)
    
    self.board = board
    
    self.boardrepeats = {}
    lettersord = board.downcase.chars.sort
    lettersord.each do |ch|
      self.boardrepeats[ch.to_sym]||= 0
      self.boardrepeats[ch.to_sym] += 1
    end
    
    words = []
    
    node = @root
    node.each do |key,subnode|
      if key != :words
        words.concat solve_subnode(subnode, key) if subnode
      end
    end
    words
  end

end


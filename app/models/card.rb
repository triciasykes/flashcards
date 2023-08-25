class Card < ApplicationRecord
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |card|
        csv << card.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      card_hash = row.to_hash
      card = find_or_create_by!(word: card_hash['word'], definition: card_hash['definition'])
      card.update(card_hash)
    end
  end
end

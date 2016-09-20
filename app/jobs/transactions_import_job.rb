class TransactionsImportJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    files = Dir.entries("#{Rails.root}/app/services/transactions/files/inputs")
    files.each do |file|
      next if file == "." || file == ".."
      document = Nokogiri::XML(open("#{Rails.root}/app/services/transactions/files/inputs/#{file}"))
      unique_id = document.xpath('/transaction/@unique_id').text
      user = User.find_by_email document.xpath('/transaction/user').text
      category = Category.find_by_name document.xpath('/transaction/category').text
      account = Account.find_by_name document.xpath('/transaction/account').text
      purpose = document.xpath('/transaction/purpose').text
      sum = document.xpath('/transaction/sum').text
      movement = document.xpath('/transaction/movement').text

      next if Transaction.find_by_unique_id unique_id

      transaction = Transaction.create! user: user, category: category, account: account,
          purpose: purpose, sum: sum, movement: movement, unique_id: unique_id
      create_output(transaction)
    end
  end

  def create_output(transaction)
    sum = transaction.movement == "input" ? transaction.sum : "-#{transaction.sum}"
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.root {
        xml.transaction {
          xml.user transaction.user.email
          xml.category transaction.category.name
          xml.account transaction.account.name
          xml.purpose transaction.purpose
          xml.sum sum
          xml.movement transaction.movement
          xml.created_at transaction.created_at
        }
      }
    end
    file = File.open("app/services/transactions/files/outputs/transaction#{-transaction.id}.xml","a")
    file.puts builder.to_xml
    file.close
  end
end

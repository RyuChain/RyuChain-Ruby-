require 'digest'
require 'securerandom'
require 'httparty'
require 'json'

class BlockHeader

    def initialize
        @time
        @prevBlockHash
        @nonce
        @height
    end

    def prevBlockInfo
    end

end

class BlockChain

    def initialize
        @chain = []
        @transaction = []
        @wallet = {}
        @node = []
    end

    def make_a_wallet
        address = SecureRandom.uuid.gsub("-", "")
        @wallet[address] = 100
        @wallet
    end

    def wallet_list
        @wallet
    end

    def make_a_trans(sender, recevier, amount)

        if @wallet[sender].nil?
            "없는 지갑입니다."
        elsif @wallet[recevier].nil?
            "없는 지갑입니다."
        elsif @wallet[sender].to_f < amount.to_f
            "돈이 부족합니다."
        else

        @wallet[sender] = @wallet[sender] - amount.to_f
        @wallet[recevier] = @wallet[recevier] + amount.to_f

        trans = {
            "sender" => sender,
            "recv"   => recevier,
            "amount" => amount
        }

        @transaction << trans

        "다음 블록에 쓰여집니다." + (@chain.length + 1).to_s
    end
    end

    def mining
        
        begin
            nonce  = rand(10000000)
            hashed = Digest::SHA256.hexdigest(nonce.to_s)
        end while hashed[0..3] != "0000"

        block = {
            "nHeight" => @chain.size,
            "nTime" => Time.now.to_i,
            "nNonce" => nonce,
            "preveious_address" => Digest::SHA256.hexdigest(last_block.to_s),
            "Transactions" => @transaction
        }

        @transaction = []
        @chain << block

    end

    def last_block
        @chain[-1]
    end

    def all_chains
        @chain
    end

    def ask_block
        @node.each do |n|
            n_block = HTTParty.get("http://localhost:" + n + "/number_of_blocks").body
        
            if @chain.length < n_block.to_i
                json_chain = @chain.to_json
                HTTParty.get("http://localhost:" + n + "/recv_chain?chain=" + json_chain)
                @chain = []
            end
        end
    end

    def add_block(block)
        block.each do |b|
            @chain << b
        end
    end

    def add_port(port)
        @node << port
        @node.compact!
        @node.uniq!
    end

    def all_node
        @node
    end

end
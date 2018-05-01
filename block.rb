require 'digest'
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
    end

    def make_a_trans(sender, recvier, amount)

        trans = {
            "sender" => sender,
            "recv"   => recvier,
            "amount" => amount
        }

        @transaction << trans

        "다음 블록에 쓰여집니다." + (@chain.length + 1).to_s
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
            "preveious_address" => Digest::SHA256.hexdigest(last_block.to_s)
        }

        @chain << block

    end

    def last_block
        @chain[-1]
    end

    def all_chains

        @chain

    end

end
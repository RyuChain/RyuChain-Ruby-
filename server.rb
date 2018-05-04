# encoding: UTF-8

require 'sinatra'
require './block'

blockchain = BlockChain.new

get '/' do

    message = "<center>"

    blockchain.all_chains.each do |eachBlock|
        message << "BlockHeight        : " + eachBlock["nHeight"].to_s + "<br>"
        message << "Time               : " + eachBlock["nTime"].to_s + "<br>"
        message << "Nonce              : " + eachBlock["nNonce"].to_s + "<br>"
        message << "Previous_BlockHash : " + eachBlock["preveious_address"].to_s + "<br>"
        message << "Cur_BlockHash      : " + Digest::SHA256.hexdigest(eachBlock.to_s) + "<br>"
        message << "Cur_Transaction    : " + eachBlock["Transactions"].to_s + "<br>"
        message << "<hr>"
    end

    message << "</center>"
    message
end

get '/mine' do    
    blockchain.mining.to_s
end

get '/trans' do
    blockchain.make_a_trans(params["send"], params["recv"], params["amount"])
end

get '/new_wallet' do
    blockchain.make_a_wallet.to_s
end

get '/wallet_list' do
    blockchain.wallet_list.to_s
end

get '/number_of_blocks' do
    blockchain.all_chains.size.to_s
end

get '/ask' do
    blockchain.ask_block
end

get '/add_node' do
    port = params["port"]
    blockchain.add_port(port)
end

get '/all_node' do
    blockchain.all_node.to_s
end

get '/recv_chain' do
    recv_chain = params["chain"]
    extracted = JSON.parse(recv_chain)
    blockchain.add_block(extracted)
end
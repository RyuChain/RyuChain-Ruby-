# encoding: UTF-8

require 'sinatra'
require './block'

blockchain = BlockChain.new

get '/' do
    blockchain.allchains.to_s
end

get '/mine' do    
    blockchain.mining.to_s
end
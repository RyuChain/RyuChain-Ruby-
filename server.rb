# encoding: UTF-8

require 'sinatra'
require './block'

cDog = Dog.new

get '/' do
    "Dog " + cDog.my_weighht
end

get '/eat' do
    cDog.eat
    '먹었음'
end
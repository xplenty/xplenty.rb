require File.expand_path("#{File.dirname(__FILE__)}/../lib/xplenty/api")

require 'rubygems'
gem 'minitest' # ensure we are using the gem version
require 'minitest/autorun'
require 'time'

MOCK = ENV['MOCK'] != 'false'

def xplenty
  # ENV['XPLENTY_API_KEY'] used for :api_key
  # ENV['XPLENTY_ACCOUNT_ID'] used for :account_id

  ENV['XPLENTY_ACCOUNT_ID'] ||= 'test_account' if MOCK

  Xplenty::API.new(:mock => MOCK)
end

def random_name
  "xplenty-rb-#{SecureRandom.hex(10)}"
end

def with_cluster(params={}, &block)
  cluster = (xplenty.clusters.body || []).select{|x| ['available', 'creating', 'pending'].include? x['status']}.first
  cluster ||= xplenty.create_cluster(params).body
  @cluster_id = cluster['id']
  ready = false
  until ready
    ready = xplenty.get_cluster_info(@cluster_id).body['status'] == 'available'
  end
  yield(cluster)
end
